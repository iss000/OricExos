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
#define via_ca1_rise  %00000001
#define via_ca1_fall  ($ff ^ via_ca1_rise)

#define via_bit_sr    2
#define via_irq_sr    (1<<via_bit_sr)

#define via_bit_cb2   3
#define via_irq_cb2   (1<<via_bit_cb2)

#define via_bit_cb1   4
#define via_irq_cb1   (1<<via_bit_cb1)
#define via_cb1_rise  %00010000
#define via_cb1_fall  ($ff ^ via_cb1_rise)

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
// interrupt vectors when 
// overlay enabled
#define irq_rom_addrlo $fffe
#define irq_rom_addrhi $ffff
#define nmi_rom_addrlo $fffa
#define nmi_rom_addrhi $fffb
#define rst_rom_addrlo $fffc
#define rst_rom_addrhi $fffd

// interrupt vectors when 
// rom enabled
#define irq_ram_addrlo $0245
#define irq_ram_addrhi $0246
#define nmi_ram_addrlo $0248
#define nmi_ram_addrhi $0249
#define rst_ram_addrlo nmi_ram_addrlo
#define rst_ram_addrhi nmi_ram_addrhi


// --------------------------
//  some useful atmos rom 
//  functions
// 
#define r_cls         $ccce
#define r_print       $ccb0
#define r_pstat       $e5ea
#define r_cstat       $e5f5
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

// --------------------------
// inter process common area (ipc)
#define ipc_ptr       $bfe0
#define ipc_id        ipc_ptr+0
#define ipc_exos      ipc_ptr+1
#define ipc_vsync     ipc_ptr+2

#else

#define id_addr       0xedb0

// --------------------------
// inter process common area (ipc)
typedef struct s_ipc {
  unsigned char id;
  unsigned char exos;
  unsigned char ipc_vsync[3];
} t_ipc,*p_ipc;

extern t_ipc ipc;

void sei(void);
void cli(void);

void phi(void);
void pli(void);

extern unsigned int _sleept;
void _sleep(void);
#define sleep(x)  {_sleept=(x),_sleep();}

void reset_exos(void);

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

void set_vsync_on(void);
void set_vsync_off(void);

#endif /* ASSEMBLER */

#endif /* __ORIC_EXOS_H__ */
