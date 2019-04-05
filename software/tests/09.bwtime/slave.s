#include <defasm.h>
#include <oricexos.h>

.text
        sei
        jsr   r_hires
        jmp   (0)
