#!/bin/bash
# $val=6
# do ((i=0; i<23; i++));
#  gmx grompp -f npt_umbrella.mdp -c conf${val}.gro -p topol.top -r conf${val}.gro -n index.ndx -o npt${i}.tpr
#  gmx mdrun -deffnm npt${i} -v
#  $val=$((val+20))
#  done

val=6
for ((i=0; i<23; i++)); do
    gmx grompp -f md_umbrella.mdp -c npt${i}.gro -t npt${i}.cpt -p topol.top -r npt${i}.gro -n index.ndx -o umbrella${i}.tpr -maxwarn 4
    gmx mdrun -deffnm umbrella${i} -v -ntomp 32 -ntmpi 1 -gpu_id 1
done

