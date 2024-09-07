#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

void error(const char * message){
    perror(message);
    exit(1);
}

void read_matrix(int **matrix, int *size) {
    printf("[+] Please enter the size of the matrix: ");
    scanf("%d", size);

    *matrix = (int *)malloc((*size) * sizeof(int));
    if (*matrix == NULL) {
        error("Memory allocation failed");
    }

    for (int i = 0; i < *size; i++) {
        printf("Element [%d]: ", i);
        scanf("%d", &(*matrix)[i]); // Fixed dereferencing issue
    }
}

void print_menu(){
    printf("[+] Please enter the number corresponding to the function you would like to use\n");
    printf("[+] 1. Calculate the average value of a matrix\n");
    printf("[+] 2. Find the minimum and the maximum value of a matrix\n");
    printf("[+] 3. Calculate a * Y\n");
    printf("[+] 4. Quit\n");
    printf("Choice: ");
}


int main(int argc, char *argv[]){
    int sockfd, portnum;
    struct  sockaddr_in server_address;
    struct hostent *server;

    if(argc < 3){
        fprintf(stderr, "usage %s hostname port\n", argv[0]);
    }

    //create the socket
    portnum = atoi(argv[2]);
    //TODO check if there is another way to do this
    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if(sockfd < 0){
        error("[-] Error opening socket...");
    }
    
    server = gethostbyname(argv[1]);
    if(server == NULL){
        error("[-] Error finding host...");
    }

    bzero((char *) &server_address, sizeof(server_address));
    server_address.sin_family = AF_INET;
    //TODO addr only in the other project
    bcopy((char *) server->h_addr_list[0], (char *) &server_address.sin_addr.s_addr, server->h_length);
    server_address.sin_port = htons(portnum);

    printf("Connecting...\n");

    if(connect(sockfd, (struct sockaddr *) &server_address, sizeof(server_address)) < 0){
        error("[-] Error conecting...");
    }

    printf("Connected sucessfully");



    int *matrix;
    int size;

    int choice=0;
    int input_val=0;
    int ret_val;
    double real_num;

    float calc_mean_res;
    int min_max_res[2];
    double *scale_mult_res;

    while(choice!=4){
        do{
            print_menu();
            ret_val = scanf("%d", &choice);
            if(ret_val <=0){
                error("[-] Error: Please try entering a valid number between 1 and 4");
            }
        }while(choice <=0 || choice >=5);

        //send the menu choice
        send(sockfd, &choice, sizeof(int), 0);

		switch (choice){
			case 1:
                read_matrix(&matrix, &size);
                //send the matrix
                send(sockfd, &size, sizeof(int), 0);
                send(sockfd, matrix, size*sizeof(int), 0);
                recv(sockfd, &calc_mean_res, sizeof(float), 0);

                //print the results
                printf("\nThe result is: %.2f", calc_mean_res);
                printf("\n\n");
                free(matrix);
				break;
			case 2:
                read_matrix(&matrix, &size);
                send(sockfd, &size, sizeof(int), 0);
                send(sockfd, matrix, size * sizeof(int), 0);
                recv(sockfd, min_max_res,2 * sizeof(int), 0);

                
                printf("\n[+] The minimum value of the matrix is: %d\n", min_max_res[0]);
                printf("[+] The maximum value of the matrix is: %d\n", min_max_res[1]);
                free(matrix);
				break;
			case 3:
                read_matrix(&matrix, &size);
                //read the number
                printf("Please enter the value of the real number a: ");
                scanf("%lf", &real_num);

                send(sockfd, &size, sizeof(int), 0);
                send(sockfd, matrix, size * sizeof(int), 0);
                send(sockfd, &real_num, sizeof(double), 0);

                scale_mult_res = (double *)malloc(size * sizeof(double));
                recv(sockfd, scale_mult_res, size * sizeof(double), 0);
                //print the results
                printf("\nThe result is: ");
                for (int i = 0; i < size; i++) {
                    printf("%.2f \t", scale_mult_res[i]);
                }
                printf("\n");
                free(matrix);
                free(scale_mult_res);
				break;
			case 4:
				printf("[-] Exit...\n");
                close(sockfd);
                return 0;
		}

    }
    close(sockfd);
    return 0;
}



