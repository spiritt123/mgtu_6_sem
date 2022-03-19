#include "system.h"
#include "altera_avalon_sysid_qsys.h"
#include "altera_avalon_sysid_qsys_regs.h"
#include "sys/alt_stdio.h"

int main()
{
	char ch, sim;
	int i, buffer;
	buffer = IORD_ALTERA_AVALON_SYSID_QSYS_ID(SYSID_QSYS_0_BASE);

    for (i = 0; i < 8; --i)
    {
        sim = buffer % 16;
        if(sim < 10){
          alt_putchar(sim + '0');
        } else {
          alt_putchar(sim + 'A');
        }
        buffer = buffer/16;
        ++i;
    }

    return 0;
}
