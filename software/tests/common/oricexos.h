#ifndef __ORIC_EXOS_H__
#define __ORIC_EXOS_H__

#ifdef ASSEMBLER

// --------------------------
#define via_b         $0300
#define via_a         $0301
#define via_ddrb      $0302
#define via_ddra      $0303
#define via_t1cl      $0304
#define via_t1ch      $0305
#define via_t1ll      $0306
#define via_t1lh      $0307
#define via_t2ll      $0308
#define via_t2lh      $0309
#define via_t2cl      $0308
#define via_t2ch      $0309
#define via_sr        $030a
#define via_acr       $030b
#define via_pcr       $030c
#define via_ifr       $030d
#define via_ier       $030e
#define via_aor       $030f

#define via_bit_ca2   0
#define via_irq_ca2   (1<<via_bit_ca2)

#define via_bit_ca1   1
#define via_irq_ca1   (1<<via_bit_ca1)
#define via_ca1_rise  via_irq_ca1
#define via_ca1_fall  ($ff ^ via_irq_ca1)

#define via_bit_sr    2
#define via_irq_sr    (1<<via_bit_sr)

#define via_bit_cb2   3
#define via_irq_cb2   (1<<via_bit_cb2)

#define via_bit_cb1   4
#define via_irq_cb1   (1<<via_bit_cb1)
#define via_cb1_rise  via_irq_cb1
#define via_cb1_fall  ($ff ^ via_irq_cb1)

#define via_bit_t2    5
#define via_irq_t2    (1<<via_bit_t2)
#define via_mask_t2   ($7f ^ via_irq_t2)

#define via_bit_t1    6
#define via_irq_t1    (1<<via_bit_t1)
#define via_mask_t1   ($7f ^ via_irq_t1)


// --------------------------
//  the value on address is 
//  used as ID of every oric
//  PEEK(#EDB0) AND 7
//  
#define id_addr       $edb0

// --------------------------
//  some useful atmos rom 
//  functions
// 
#define r_cls         $ccce
#define r_print       $ccb0
#define r_cload       $e874
#define r_text        $ec21
#define r_lores0      $d9ed
#define r_lores1      $d9ea
#define r_hires       $ec33

//  restore VIA settings and clear flag I
#define r_via_reset   $e93d

//  init VIA (disable T1 interrupt) and set flag I
#define r_via_set     $e76a

// --------------------------
//  ... params in page 2 for
//  above functions
// 
#define b_paper       $026b
#define b_ink         $026c

#else
void set_ram_on(void);
void set_rom_off(void);
void set_rom_on(void);
void set_ram_off(void);
void set_pp_on(void);
void set_pp_off(void);
void set_pp_in(void);
void set_pp_out(void);
void set_mix_a(void);
void set_mix_b(void);
#endif

#endif /* __ORIC_EXOS_H__ */
