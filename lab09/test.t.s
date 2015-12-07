    .text
    .globl tstconst
tstconst:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    movl       $10, %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstcall
tstcall:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    push      $10
    push      $100
    push      $strval0
 movl    $printf , %eax
    call     *%eax
 addl   $12, %esp
    movl       $10, %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .data
    .globl strval0
strval0:
    .asciz    "Test: %d %d\n"

    .text
    .globl tstadd
tstadd:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    movl       264(%esp), %eax
    addl       268(%esp), %eax
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstsub
tstsub:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    movl       264(%esp), %eax
    subl       268(%esp), %eax
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstmul
tstmul:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    movl       264(%esp), %eax
    imul       268(%esp), %eax
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstdiv
tstdiv:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
     movl      $0, %edx
    movl       264(%esp), %eax
    idivl      268(%esp)
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstmod
tstmod:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
     movl      $0, %edx
    movl       264(%esp), %eax
    idivl      268(%esp)
    movl        %edx, %eax
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstshl
tstshl:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    movl       264(%esp), %eax
    mov        268(%esp), %cl
     sall      %cl, %eax
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

    .text
    .globl tstshr
tstshr:
    push       %ebp
    movl       %esp, %ebp
    subl       $256, %esp
    movl       264(%esp), %eax
    mov        268(%esp), %cl
     sarl      %cl, %eax
    movl       %eax, 272(%esp)
    movl       272(%esp), %eax
    addl       $256, %esp
    pop        %ebp
    ret

