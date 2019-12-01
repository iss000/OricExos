#ifndef __VIA_H__
#define __VIA_H__

#ifdef ASSEMBLER
#define via_b         $0300
#define via_a         $0301
#define via_ddrb      $0302
#define via_ddra      $0303
#define via_t1cl      $0304
#define via_t1ch      $0305
#define via_t1ll      $0306
#define via_t1lh      $0307
#define via_t2ll      $0308
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

#else
#define via_b         0x300
#define via_a         0x301
#define via_ddrb      0x302
#define via_ddra      0x303
#define via_t1cl      0x304
#define via_t1ch      0x305
#define via_t1ll      0x306
#define via_t1lh      0x307
#define via_t2ll      0x308
#define via_t2ch      0x309
#define via_sr        0x30a
#define via_acr       0x30b
#define via_pcr       0x30c
#define via_ifr       0x30d
#define via_ier       0x30e
#define via_aor       0x30f

typedef struct _via_s {
  unsigned char b;
  unsigned char a;
  unsigned char ddrb;
  unsigned char ddra;
  unsigned char t1cl;
  unsigned char t1ch;
  unsigned char t1ll;
  unsigned char t1lh;
  unsigned char t2ll;
  unsigned char t2ch;
  unsigned char sr;
  unsigned char acr;
  unsigned char pcr;
  unsigned char ifr;
  unsigned char ier;
  unsigned char aor;
} via_t, *via_p;

extern const via_t via;

#endif

#endif /* __VIA_H__ */
