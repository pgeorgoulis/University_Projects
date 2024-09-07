struct y_vector{
    int data<>;
    int length;
};


struct min_max{
    int values[2];
};


struct scale_result{
    double scale_input<>;
    int length;
};

struct scale_input{
    double a;
    int data<>;
    int length;
};


program calc_mean_PROG{
    version calc_mean_VERS{
        double calc_mean(y_vector) = 1;
    } = 1;

}= 0x20000000;


program calc_min_max_PROG{
    version calc_min_max_VERS{
        min_max FIND_MIN_MAX(y_vector) = 2;
    } = 1;

}= 0x20001000;


program calc_scale_PROG{
    version calc_scale_result_VERS{
        scale_result SCALE_MULTIPLY(scale_input) = 3;
    } = 1;

}= 0x20002000;
