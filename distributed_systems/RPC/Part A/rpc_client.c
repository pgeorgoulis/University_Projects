/*
 * This is sample code generated by rpcgen.
 * These are only templates and you can use them
 * as a guideline for developing your own functions.
 */

#include "rpc.h"
#include <pthread.h>	//χρηση thread για δυνατότητα πολων χρηστών


void
calc_mean_prog_1(char *host)
{
	CLIENT *clnt;
	double  *result_1;
	y_vector  calc_mean_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, calc_mean_PROG, calc_mean_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */
	int array_length;
	printf("[+] Please enter the size of the matrix: ");
	scanf("%d", &array_length);
	calc_mean_1_arg.length = array_length;
	calc_mean_1_arg.data.data_len = array_length;
	calc_mean_1_arg.data.data_val = (int *)malloc(calc_mean_1_arg.length * sizeof(int));
	if (calc_mean_1_arg.data.data_val == NULL) {
        fprintf(stderr, "[-] Memory allocation failed.\n");
        exit(1);
    }
	
	
	/*Read the matrix values*/
	for(int i=0; i<array_length; i++){
		printf("Please enter a value: ");
		scanf("%d", &calc_mean_1_arg.data.data_val[i]);
	}
	result_1 = calc_mean_1(&calc_mean_1_arg, clnt);

	if (result_1 == (double *) NULL) {
		clnt_perror (clnt, "call failed");
	}

	printf("\n[+] The result is: %.2f\n\n", *result_1);
	free(calc_mean_1_arg.data.data_val);

#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}



void
calc_min_max_prog_1(char *host)
{
	CLIENT *clnt;
	min_max  *result_1;
	y_vector  find_min_max_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, calc_min_max_PROG, calc_min_max_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

	int len;
	printf("[+] Please enter the size of the matrix: ");
	scanf("%d", &len);
	find_min_max_1_arg.length = len;
	find_min_max_1_arg.data.data_len = len;
	find_min_max_1_arg.data.data_val = (int *)malloc(find_min_max_1_arg.length * sizeof(int));
	if (find_min_max_1_arg.data.data_val == NULL) {
        fprintf(stderr, "[-] Memory allocation failed.\n");
        exit(1);
    }
	/*Read the matrix values*/
	int i=0;
	for(i=0; i<find_min_max_1_arg.length; i++){
		printf("Please enter a value: ");
		scanf("%d", &find_min_max_1_arg.data.data_val[i]);
	}



	result_1 = find_min_max_1(&find_min_max_1_arg, clnt);
	if (result_1 == (min_max *) NULL) {
		clnt_perror (clnt, "call failed");
	}else{
		printf("\n[+] The minimum value of the matrix is: %d\n[+] The maximum value of the matrix is: %d\n\n", result_1->values[0], result_1->values[1]);
	}
	free(find_min_max_1_arg.data.data_val);

#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}


void
calc_scale_prog_1(char *host)
{
	CLIENT *clnt;
	scale_result  *result_1;
	scale_input  scale_multiply_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, calc_scale_PROG, calc_scale_result_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

	int len;
	printf("[+] Please enter the size of the matrix: ");
	scanf("%d", &len);
	scale_multiply_1_arg.length = len;
	scale_multiply_1_arg.data.data_len = len;
	scale_multiply_1_arg.data.data_val = (int *)malloc(scale_multiply_1_arg.length * sizeof(int));

	/*Read the matrix values*/
	int i=0;
	for(i=0; i<len; i++){
		printf("Please enter a value for the matrix: ");
		scanf("%d", &scale_multiply_1_arg.data.data_val[i]);
	}

	printf("Please enter the value of the real number a: ");
	scanf("%lf", &scale_multiply_1_arg.a);

	result_1 = scale_multiply_1(&scale_multiply_1_arg, clnt);
	if (result_1 == (scale_result *) NULL) {
		clnt_perror (clnt, "call failed");
		free(scale_multiply_1_arg.data.data_val);
		exit(1);
	}
	printf("\nThe result is: ");
	for(int i=0; i<result_1->length; i++){
		printf("%.2f \t", result_1->scale_input.scale_input_val[i]);
	}
	printf("\n\n");
	free(scale_multiply_1_arg.data.data_val);
	free(result_1->scale_input.scale_input_val);

#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}


int
main (int argc, char *argv[])
{
	char *host;
	int choice =0;
	int ret_value =0;


	if (argc < 2) {
		printf ("usage: %s server_host\n", argv[0]);
		exit (1);
	}

	host = argv[1];
	while(choice!=4){
		do{
			printf("[+] Please enter the number corresponding to the function you would like to use\n");
			printf("[+] 1. Calculate the average value of a matrix 	\n[+] 2. Find the minimum and the maximum value of a matrix	\n[+] 3. Calculate a * Y\n[+] 4. Quit\n	\nChoice:	");
			ret_value = scanf("%d", &choice);
			if(ret_value <= 0){
				printf("Error: Please try entering a valid number between 1 and 4\n");
			}
		}while(choice<=0 || choice >= 5);
		
		switch (choice){
			case 1:
				calc_mean_prog_1(host);
				break;
			case 2:
				calc_min_max_prog_1(host);
				break;
			case 3:
				calc_scale_prog_1(host);
				break;
			case 4:
				printf("[-] Exit...\n");
		}
	}
	exit (0);
}