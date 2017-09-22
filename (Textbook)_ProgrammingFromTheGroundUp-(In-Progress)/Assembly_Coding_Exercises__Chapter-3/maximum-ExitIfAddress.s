#PURPOSE: This program finds the maximum number of a 
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
# data_items - contains the item data. 
#
# We exit if the current address of data_items matches address of the last 
# word in the data_items 
#

.section .data 

data_items: 					#These are the data items 
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0 

.section .text 

.globl _start 
_start: 
movl $data_items, %edi 					# move 0 into the index register 
movl %edi, %eax 			# load the first byte of data 
movl %eax, %ebx 				# since this is the first item, %eax is  the biggest 

start_loop: # start loop 
	cmp $data_items + 4*13, %edi		# check to see if we’ve hit the end 
	je loop_exit 
	add  $4,   %edi				# load next value with a manual addition operation		
	movl %edi, %eax 
	cmpl %ebx, %eax				# compare values 
	jle start_loop				# jump to loop beginning if the new 
						# one isn’t bigger 
	movl %eax, %ebx
						# move the value as the largest 

jmp start_loop 					# jump to loop beginning 

loop_exit: 
movl $1, %eax			# %ebx is the status code for the exit system call 
				# and it already has the maximum number 
int $0x80			#1 is the exit() syscall                
