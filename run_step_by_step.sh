#/bin/bash
echo "1 1 0 0" |gmx pdb2gmx -f str.pdb -ignh -ter -o str.gro
gmx editconf -f str.gro -o newbox.gro -center 3.280 2.181 2.4775 -box 6.560 4.362 12
gmx solvate -cp newbox.gro -cs spc216.gro -o solv.gro -p topol.top
gmx grompp -f ions.mdp -c solv.gro -p topol.top -o ions.tpr
echo "13" |gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -pname NA -nname CL -neutral -conc 1.0
gmx grompp -f minim.mdp -c solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f npt.mdp -c em.gro -p topol.top -r em.gro -o npt.tpr -maxwarn 2
gmx mdrun -deffnm npt -v
#gmx make_ndx -f npt.gro
gmx grompp -f md_pull.mdp -c npt.gro -p topol.top -r npt.gro -n index.ndx -t npt.cpt -o pull.tpr -maxwarn 3
gmx mdrun -deffnm pull -pf pullf.xvg -px pullx.xvg -v
#gmx trjconv -s pull.tpr -f pull.xtc -o conf.gro -n index.ndx
./get_distances.sh
./run_umbrella.sh
python analysis_input.py
gmx wham -it tpr_files.dat -if pullf_files.dat -o -hist -unit kJ