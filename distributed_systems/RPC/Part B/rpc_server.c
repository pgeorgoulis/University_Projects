/*
 * This is sample code generated by rpcgen.
 * These are only templates and you can use them
 * as a guideline for developing your own functions.
 */

#include "rpc.h"

double *
calc_mean_1_svc(y_vector *argp, struct svc_req *rqstp){
	printf("Calculate mean function called");
	static double  result;

	int i;
	int sum =0;
	int len = argp->data.data_len;


	for(i=0; i<len;i++){
		sum+= argp->data.data_val[i];
	}

	result = sum / (double)len;

	return (&result);
}

min_max *
find_min_max_1_svc(y_vector *argp, struct svc_req *rqstp)
{
	static min_max  result;

	printf("Calculate min max function called");
	int i;
	int min, max, temp;
	
	min = argp->data.data_val[0];
	max = argp->data.data_val[0];

	for(i=0;i<argp->length; i++){
		temp = argp->data.data_val[i];

		/*Calculate min*/
		if(temp < min){
			min = temp;
		}

		/*Calculate max*/
		if(temp > max){
			max = temp;
		}
	}
	result.values[0] = min;
	result.values[1] = max; 
	return &result;
}

scale_result *
scale_multiply_1_svc(scale_input *argp, struct svc_req *rqstp)
{
    static scale_result  result;
    int i;

    // Free previously allocated memory if necessary
    if (result.scale_input.scale_input_val != NULL) {
        free(result.scale_input.scale_input_val);
    }

    // Allocate memory for the result array
    result.length = argp->length;
    result.scale_input.scale_input_val = (double *)malloc(result.length * sizeof(double));
    if (result.scale_input.scale_input_val == NULL) {
        fprintf(stderr, "[ERROR] Memory allocation failed on server.\n");
        exit(1);
    }

    printf("[DEBUG] Server received a = %.2f, length = %d\n", argp->a, argp->length);
    printf("[DEBUG] Server received data: ");
    for (i = 0; i < argp->length; i++) {
        printf("%d ", argp->data.data_val[i]);
    }
    printf("\n");

    // Perform the scaling operation
    for (i = 0; i < result.length; i++) {
        result.scale_input.scale_input_val[i] = argp->a * argp->data.data_val[i];
        printf("[DEBUG] Result[%d] = %.2f\n", i, result.scale_input.scale_input_val[i]);
    }

    return &result;
}