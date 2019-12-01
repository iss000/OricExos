#ifndef __ISR_H__
#define __ISR_H__

/*
 * Conditional defines:
 * USE_NO_ROM
*/

#ifdef ASSEMBLER

#ifdef USE_NO_ROM
#define    irq_addrlo        $fffe
#define    irq_addrhi        $ffff
#define    rst_addrlo        $fffc
#define    rst_addrhi        $fffd
#define    nmi_addrlo        $fffa
#define    nmi_addrhi        $fffb
#else
#define    irq_addrlo_atmos  $0245
#define    irq_addrhi_atmos  $0246
#define    nmi_addrlo_atmos  $0248
#define    nmi_addrhi_atmos  $0249
#define    irq_addrlo_oric1  $0229
#define    irq_addrhi_oric1  $022a
#define    nmi_addrlo_oric1  $022c
#define    nmi_addrhi_oric1  $022d
#endif

#else

#ifdef USE_NO_ROM
#define    irq_addrlo        0xfffe
#define    irq_addrhi        0xffff
#define    rst_addrlo        0xfffc
#define    rst_addrhi        0xfffd
#define    nmi_addrlo        0xfffa
#define    nmi_addrhi        0xfffb
#else
#define    irq_addrlo_atmos  0x0245
#define    irq_addrhi_atmos  0x0246
#define    nmi_addrlo_atmos  0x0248
#define    nmi_addrhi_atmos  0x0249
#define    irq_addrlo_oric1  0x0229
#define    irq_addrhi_oric1  0x022a
#define    nmi_addrlo_oric1  0x022c
#define    nmi_addrhi_oric1  0x022d
#endif

extern unsigned int isr_period;
#define isr_set_period(x)    {isr_period=(x)-2;}

typedef unsigned char isr_timer_t[6];

extern isr_timer_t isr_timer;
extern const char* isr_timer_str;

void isr_open(void);
void isr_close(void);

void isr_timer_set(void);
void isr_timer_get(void);

#ifdef USE_TIMER_STRINGS
void isr_timer_get_str(void);
#endif /* USE_TIMER_STRINGS */

char isr_timeout(void);

void sei(void);
void cli(void);

#endif

#endif /* __ISR_H__ */
