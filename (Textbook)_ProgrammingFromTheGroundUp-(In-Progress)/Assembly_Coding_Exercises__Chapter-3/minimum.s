#PURPOSE: This program finds the minimum number of a 
# set of data items. 
# 

#VARIABLES: The registers have the following uses: 
# 
# %edi - Holds the index of the data item being examined 
# %ebx - Largest data item found 
# %eax - Current data item 
# 
# The following memory locations are used: 
# 
# data_items - contains the item data. A 0 is used 
# to terminate the data 
#

.section .data 

data_items: 					#These are the data items 
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0 

.section .text 

.globl _start 
_start: 
movl $0, %edi 					# move 0 into the index register 
movl data_items(,%edi,4), %eax 			# load the first byte of data 
movl %eax, %ebx 				# since this is the first item, %eax is  the smallest 

start_loop: # start loop 

	incl %edi 				# increment counter 
	movl data_items(,%edi,4), %eax 		# load next value
	cmpl %ebx, %eax				# compare values 
	jge start_loop				# jump to loop beginning if eax is bigger 

	cmpl $0, %eax				# if eax isn't bigger, make sure it isn't zero
	je loop_exit				# exit if it is
				
	movl %eax, %ebx				# move value to ebx if it's smaller
	jmp start_loop				# then jump to loop beginning 

loop_exit: 
movl $1, %eax			# %ebx is the status code for the exit system call 
				# and it already has the maximum number 
int $0x80			#1 is the exit() syscall                
