/**
 * Program implementing recursive functions for Singly Linked List
 *
 * Author: Rahul Nair (rkn130030)
 **/
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#define MAX 50

typedef struct cell {
	int data;
	struct cell *next;
} CELL;

FILE *fp;
CELL *head = NULL;
CELL *node = NULL;
int arrayIndex;
CELL *headPtrs[MAX];//Array to store the head pointers of generated lists
/**
 * Recursive function to find the last element of the Linked list
 **/
int last(CELL *p)
{
	if(p != NULL) {
		if (p->next == NULL) {
			return p->data;
		}
		return last(p->next); // Recursive call
	}
	return -1;
}

/**
 * Recursive function to append a given cell to the linked list
 **/
CELL *append(CELL *p, CELL *q)
{
	if (p == NULL) {
		p = q;
	} else if (p->next != NULL) {
		append(p->next, q); //Recursive call
	} else {
		p->next = q;
	}
	return p;
}

/**
 * Recursive function to reverse the Linked list
 **/
CELL *reverse(CELL *p)
{
	CELL *current, *next;
	if(p == NULL || p->next==NULL) {
		return p;
	}
	current=p;
	next = reverse(p->next); // Recursive call
	current->next->next = current;
	current->next=NULL;
	return next;
}

/**
 * Recursive function to print the elements of the Linked list in ML syntax
 **/
void printList(CELL *node)
{
	if(node != NULL) {
		printf("%d", node->data);
		if (node->next != NULL) {
			printf(",");
			printList(node->next);//Recursive call
		}
	}
}

/**
 * Function to call recursive function printList
 **/
void print(CELL *node)
{
	printf("[");
	printList(node);
	printf("]\n");
}

/**
 * Recursive function to check if given number is present in the Linked list
 **/
int member(int n, CELL *p)
{
	if(p != NULL) {
		if(p->data == n) {
			return 1;
		}
		return member(n, p->next);
	}
	return 0;
}

/**
 * Recursive function to delete the given number from the linked list
 **/
CELL *delete(int n, CELL *p)
{
	if (p == NULL)
		return NULL;
	if (p->data == n) {
		CELL *temp;
		temp = p->next;
		p= NULL;
		free(p);
		return temp;
	}
	p->next= delete(n, p->next);
	return p;
}


/**
 * Function to create the linked list from file input
 **/
CELL *createlist()
{
	CELL *currentNode;
	int inputData;

	int ret = fscanf(fp, "%d", &inputData);
	if(ret == EOF) {
		return NULL;
	} else if(ret == 1) {
		if(inputData==-1) {
			if(!feof(fp)) {
				arrayIndex++;
				headPtrs[arrayIndex]=(CELL *)createlist();//New List created using recursion
				return NULL;
			} else {
				return NULL;//File end
			}
		}
		currentNode = (CELL *) malloc(sizeof(CELL));
		currentNode->data = inputData;
		currentNode->next = createlist(); // Recursive call
		return currentNode;
	}
	return NULL;
}

/**
 * Main function
 **/
int main(int argc, char **argv)
{
	int loopIndex = 0;
	for(loopIndex=0; loopIndex < MAX; loopIndex++) {
		headPtrs[loopIndex] = NULL;
	}
	if((fp = fopen("..\\input.txt", "r+")) == NULL) {
		printf("No such file\n");
		return 1;
	}
	printf("\nRecursive operations on lists\n\n");
	printf("Lists created from file- \n");
	arrayIndex = 0;
	headPtrs[arrayIndex] = createlist();
	loopIndex =0;
	//Printing the lists generated, for reference
	while(headPtrs[loopIndex] != NULL) 
	{
		print(headPtrs[loopIndex]);
		loopIndex++;
	}
	//Performing different operations using the first two lists
	printf("\nPerforming different operations using first two lists -\n\n");
	if(headPtrs[0] != NULL) {
		printf("\nOutput for member function call for value 20 on List-1: %d \n", member(20,headPtrs[0]));
		printf("\nUpdated List-1 after deleting 20 : ");
		headPtrs[0] = delete(20, headPtrs[0]);
		print(headPtrs[0]);

		printf("\nLast element of the List-1 : %d \n",last(headPtrs[0]));

		printf("\nAppend List-1 and List-2 : ");
		print(append(headPtrs[0], headPtrs[1]));

		printf("\nReversing the above combined list: ");
		print(reverse(headPtrs[0]));

	}
	return 0;
}
