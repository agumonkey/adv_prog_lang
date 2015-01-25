/**
 * Program implementing functions for Singly Linked List
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

/**
 * Function to find the last element of the Linked list
 **/
int last(CELL *p)
{
	if(p != NULL) {
		while (p->next != NULL) {
			p= p->next;
		}
		return p->data;
	}
	return -1;
}

/**
 * Function to append a given cell to the linked list
 **/
CELL *append(CELL *p, CELL *q)
{
	CELL *head = p;
	if(p != NULL && q != NULL) {
		while (p->next != NULL) {
			p= p->next;
		}
		p->next=q;
	}
	return head;
}

/**
 * Function to reverse the Linked list
 **/
CELL *reverse(CELL *p)
{
	CELL *prevCell = NULL;
	CELL *currentCell = (CELL *) malloc(sizeof(CELL));
	CELL *temp;

	currentCell = p;
	while(currentCell != NULL) {
		temp = currentCell->next;
		currentCell->next = prevCell;
		prevCell = currentCell;
		currentCell=temp;
	}
	p=prevCell;
	return p;
}

/**
 * Function to print the elements of the Linked list in ML syntax
 **/
void printList(CELL *node)
{
	printf("[");
	if(node != NULL) {
		while (node->next != NULL) {
			printf("%d", node->data);
			node= node->next;
			printf(",");
		}
		printf("%d", node->data);
	}
	printf("]\n");
}

/**
 * Function to check if given number is present in the Linked list
 **/
int member(int n, CELL *p)
{
	while(p != NULL) {
		if(p->data == n) {
			return 1;
		}
		p=p->next;
	}
	return 0;
}

/**
 * Function to delete the given number from the linked list
 **/
CELL *delete(int n, CELL *p)
{
	if(p==NULL) {
		return NULL;
	}
	CELL *prevCell = NULL;
	CELL *currentCell = (CELL *) malloc(sizeof(CELL));
	currentCell = p;
	while(currentCell->next && currentCell->data!=n) {
		prevCell = currentCell;
		currentCell = currentCell->next;
	}
	if(currentCell->next || currentCell->data==n) {
		if(prevCell==NULL) {
			p= currentCell->next;
		} else {
			prevCell->next=currentCell->next;
		}
		free(currentCell);
	}
	return p;
}

/**
 * Function to create the linked list from file input
 **/
CELL *createlist()
{
	CELL *head, *node, *currentNode;
	int inputData;
	head = NULL;
	node = (CELL *) malloc(sizeof(CELL));

	bool isHead = true;
	while(42) {
		int ret = fscanf(fp, "%d", &inputData);
		if(ret == EOF) {
			return NULL;
		} else if(ret == 1) {
			if(inputData==-1) {
				break;
			}
			currentNode = (CELL *) malloc(sizeof(CELL));
			currentNode->data = inputData;
			currentNode->next = NULL;
			node->next = currentNode;
			node= currentNode;
			if(isHead) {
				head = node;
				isHead = false;
			}
		}
	}
	printList(head);
	return head;
}

/**
 * Main function
 **/
int main(int argc, char **argv)
{
	CELL *headPtrs[MAX];
	int index;
	for(index=0; index<MAX; index++) {
		headPtrs[index] = NULL;
	}
	if((fp = fopen("..\\input.txt", "r+")) == NULL) {
		printf("No such file\n");
		return 1;
	}
	index = 0;
	printf("Lists created from file- \n");
	while(42) {
		if(!feof(fp)) {
			headPtrs[index]=(CELL *)createlist();
			index++;
		} else {
			break;
		}
	}
	//Performing different operations on the first list
	printf("\nPerforming different operations using first two lists -\n\n");
	if(headPtrs[0] != NULL) {
		printf("\nOutput for member function call for value 20 on List-1: %d \n", member(20,headPtrs[0]));
		printf("\nUpdated List-1 after deleting 20 : ");
		printList(delete(20, headPtrs[0]));

		printf("\nLast element of the List-1 : %d \n",last(headPtrs[0]));

		printf("\nAppend List-1 and List-2 : ");
		printList(append(headPtrs[0], headPtrs[1]));

		printf("\nReversing the above combined list: ");
		printList(reverse(headPtrs[0]));

	}
	return 0;
}
