#!/bin/bash

#################### Colors display ####################

RED='\033[0;31m'
BLUE='\033[01;34m'        
NC='\033[0m'          

#################### Items ####################

potion=30

#################### Link's param ####################

hpl=60
hplmax=60
hpl_last_potion=$((hplmax-potion))
strl=15

#################### Opponent's param ####################

hpo=30
hpomax=30
stro=5 

#################### Ganon's param ####################

hpg=350
hpgmax=350
strg=15

#################### Link's general actions ####################

link_die() {
	let hpl=$hpl*0
	echo " 
########### Game Over ########## "
	exit;
}

### Link's actions against opponent

link_hit() {
	if [ $hpo -gt 0 ]; then
	  let hpo=hpo-$strl
	  opponent_hit
	  
	  echo -e
	  "
Bokoblin
HP : IIIIIIIIIIIIII_______________ "$hpo"/30
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You attacked and dealt "$strl" damages!
	
Bokoblin attacked and dealt "$stro" damages!"
	  
	else
	      opponent_die
	fi
}

link_heal() {
	if [ $hpl -lt $hpl_last_potion ]; then
	  let hpl=hpl+$potion
	  opponent_hit
	  
          echo -e
	    "
Bokoblin
HP : IIIIIIIIIIIIII_______________ "$hpo"/30
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You used heal!
	
Bokoblin attacked and dealt "$stro" damages!"
	  
	else
	  let hpl=$hplmax
	  opponent_hit
	  
	echo -e
	    "
Bokoblin
HP : IIIIIIIIIIIIII_______________ "$hpo"/30
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You used heal!
	
Bokoblin attacked and dealt "$stro" damages!"
	     
	fi
}

#################### Link's actions against Ganon ####################

link_hit_g() {
	if [ $hpg -gt 0 ]; then
	  let hpg=hpg-$strl
	  ganon_hit
	  
	  echo -e
	  "
Ganon
HP : IIIIIIIIIIIIII_______________ "$hpg/$hpgmax"
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You attacked and dealt "$strl" damages!
	
Ganon attacked and dealt "$strg" damages!"
	  
	else
	      ganon_die
	fi
}

link_heal_g() {
	if [ $hpl -lt $hpl_last_potion ]; then
	  let hpl=hpl+$potion
	  ganon_hit
	  
          echo -e
	    "
Ganon
HP : IIIIIIIIIIIIII_______________ "$hpg/$hpgmax"
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You used heal!
	
Ganon attacked and dealt "$strg" damages!"
	  
	else
	  let hpl=$hplmax
	  ganon_hit
	  
	echo -e
	    "
Ganon
HP : IIIIIIIIIIIIII_______________ "$hpg/$hpgmax"
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack 2. Heal
	
1. Attack  2. Heal  0. Run 
	
Ganon attacked and dealt "$strg" damages!"
	     
	fi
}

#################### Opponent's actions ####################

opponent_hit() {
	let hpl=hpl-$stro
}

opponent_die() {
	let hpo=$hpo*0
	echo -e 
	"
Bokoblin
HP : IIIIIIIIIIIIII_______________ "$hpo"/30
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You attacked and dealt "$strl" damages !
	
Bokoblin died!
	   
=== Press any key to continue ==="
}

encounter_opponent() {
	echo -e
"
Bokoblin
HP : IIIIIIIIIIIIII_______________ "$hpomax"/30
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"

--------------Options--------------

1. Attack   2. Heal    0. Run

You encounter a Bokoblin"
}

### Gannon's actions

ganon_hit() {
	let hpl=hpl-$strg
}

ganon_die() {
	let hpg=$hpg*0
	echo -e 
	"
Ganon
HP : IIIIIIIIIIIIII_______________ "$hpg/$hpgmax"
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"
	
---Options--------------
1. Attack  2. Heal  0. Run 
	
You attacked and dealt "$strl" damages !
	
Congratulation Ganon has been defeated!
	   
=== Press any key to continue ==="
exit;
}

encounter_ganon() {
	echo -e
"
Ganon
HP : IIIIIIIIIIIIII_______________ "$hpg/$hpgmax"
	
Link
HP : IIIIIIIIIIIIII_______________ "$hpl/$hplmax"

--------------Options--------------

1. Attack   2. Heal    0. Run

You are facing Ganon!"
}

#################### Fight ####################

fight() {

######################## STAGES 1-9 ###########################

	count=1
	
	while [ $count -lt 10 ]; do
	
	  encounter_opponent		
	  while [ $hpo -gt 0 ]; do
	  
	    echo "
========= FIGHT " $count"/10 ========="
  
	    read act
	  
	  ### heal 
	    if [ $act -eq 2 ]; then
	      link_heal
	    
	  ### attack
	    elif [ $act -eq 1 ]; then
	      link_hit
	    
	  
	  ### quit
	    elif [ $act -eq 0 ]; then
	      echo '
You ve been stabbed in the back and died'
	      link_die
	      
	  ### wrong key
	    else
	      echo '
Press 1 to attack, 2 to heal or 0 to quit'
	    
	    fi
	    
	    if [ $hpl -eq 0 ];then
	      echo "
Bokoblin defeats you!
	      "
	      link_die
	    fi
	    
	  done
	  
	    let count=$count+1
	    let hpo=$hpomax
	  
	done
	
######################## STAGE 10 ###########################

	encounter_ganon
	
	while [ $hpg -gt 0 ]; do
	  
	    echo "
========= FIGHT " $count"/10 ========="
  
	    read act
	  
	  ### heal 
	    if [ $act -eq 2 ]; then
	      link_heal_g
	    
	  ### attack
	    elif [ $act -eq 1 ]; then
	      link_hit_g
	    
	  
	  ### quit
	    elif [ $act -eq 0 ]; then
	      echo '
You ve been stabbed in the back and died'
	      link_die

	  ### wrong key
	    else
	      echo '
Press 1 to attack, 2 to heal or 0 to quit'
	    
	    fi
	    
	    if [ $hpl -eq 0 ];then
	      echo "
Ganon defeats you!
	      "
	      link_die
	    fi
	    
	  done
	  
	  ganon_die
		  
}

#################### Main ####################

echo '--------------Options--------------

1. Enter The Hyrule Castle    0. Run'
while [ 1 ]; do
  read key
  if [ $key -eq 1 ]; then
    echo "
Welcome to the Hyrule Castle and get ready to fight!

"
    fight
  elif [ $key -eq 0 ]; then
    echo "
You ran away form the battlefield
########### Game Over ##########"
    exit;
  else
    echo "
Please press 0 or 1 to make an action"
  fi
done
