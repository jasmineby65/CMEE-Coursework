#include <stdio.h>
#include <string.h> 


// creating a new type of data e.g. citation, site data 
struct site_data {
    float latitude;
    float longitude;
    float elevation;
    int observed_spp[500];
    int condition;
};

typedef struct site_data site_data_s; // defining the variable type of a variable 
// This means next time you write site_data_s in code, you dont't have to write struct in front of it
// This is also useful if you want to change the variable type later 
// Just need to change it here rather than the whole program 
// But will still need to write struct if writing site_data


int main(void)
{
    struct site_data site1; // make a variable which has a site_data data type
    struct site_data site2;

    // can also make multiple at once since the computer will know how much memory needed for each already
    struct site_data mysites[3]; 


    // initialising a struct
    site1.latitude = 0.0; // But manual input like this will take too long
    
    // Instead, use memset() from <string.h>
    // memset(pointer, int, sizef_t) 
    // Takes the data specified by the pointer and for every memory bytes specified by sizef_t, it will set it to new specified byte size by int

    memset(&site1, 0, sizeof(struct site_data));
    memset(&site2, 0, sizeof(struct site_data));
    memset(mysites, 0, 3* sizeof(struct site_data)); // since arrays already work as pointer, can just use mysites direclty
    

    site1.latitude = 74.3444; // adding values to data, using "." to specify which category
    printf("The latitude of site1 is %f\n", site1.latitude);
    printf("The longtitude of site1 is %f\n", site1.longitude);


    return 0;
}