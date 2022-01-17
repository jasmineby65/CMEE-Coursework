typedef struct int_matrix int_matrix;
void initialise_matrix(int nrows, int ncols, int_matrix* m);
void dealloc_matrix(int_matrix* m);
int_matrix* new_int_matrix(int nrows, int ncols);
void set_element(int data, int row, int col, int_matrix* m);
int get_element(int row, int col, int_matrix*);