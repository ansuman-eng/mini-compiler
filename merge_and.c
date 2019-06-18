#include<stdio.h>
#include<stdlib.h>
    int arr[100];
int * merge_and(int * L, int * R) 
{ 
	int n1,n2;;
	n1=0;n2=0;
	int A=0;
    while(L[A]!=-1)
    {
    	n1++;						// n1 is size of L
    	A++;
    }
    A=0;
    while(R[A]!=-1)
    {
    	n2++;						// n1 is size of L
    	A++;
    }	

    int l=0;
    int i = 0; // Initial index of first subarray 
    int j = 0; // Initial index of second subarray 
    int k = l; // Initial index of merged subarray 


    while (i < n1 && j < n2) 
    { 
        if (L[i] <= R[j]) 
        { 
            if(L[i]==R[j])
            {
                arr[k] = L[i]; 
                k++;
            }

            i++; 
        } 
        else
        { 
            //arr[k] = R[j]; 
            j++; 
        } 
    } 
  

    arr[k]=-1;
    return arr;
} 

int main()
{
	int a[100],b[100];
	a[0]=1;
	a[1]=3;
	a[2]=5;
	a[3]=-1;


	b[0]=2;
	b[1]=5;
	b[2]=6;
	b[3]=-1;

	int * arr;
	arr= (int *)malloc(100*sizeof(int));
	arr=merge_and(a,b);

	int h = 0;
	while(arr[h]!=-1)
	{
		printf("%d",arr[h]);
		h++;
	}
}