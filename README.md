# pes_bfloat_adder

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/6fbc1713-8722-410d-8f97-efb756fb33a6)

In computing, floating-point arithmetic (FP) is arithmetic that represents subsets of real numbers using an integer with a fixed precision, called the significand, scaled by an integer exponent of a fixed base. Numbers of this form are called floating-point numbers

Floating-point arithmetic operations, such as addition and division, approximate the corresponding real number arithmetic operations by rounding any result that is not a floating-point number itself to a nearby floating-point number.[1]: 22 [2]: 10  For example, in a floating-point arithmetic with five base-ten digits of precision, the sum 12.345 + 1.0001 = 13.3451 might be rounded to 13.345.

# Implementation

<details>
<summary>Synthesis</summary>
<br>

```
yosys
read_liberty -lib <path to your lib file>
read_verilog bfloat_adder.v
synth -top bfloat_adder
dfflibmap -liberty
abc -liberty
flatten
show
write_verilog bfloat_adder_mapped.v
```

#### Statistics

![Screenshot from 2023-10-20 20-59-38](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/386c00aa-2480-41a6-8ed6-67b334574ce2)

#### Logic Synthesis

![Screenshot from 2023-10-20 20-33-32](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/24bd86a8-9ba4-44bb-97c7-80efaaf6dfd4)

</details>

<details>
<summary>Gate Level Simulation</summary>
<br>

### Pre Synthesis Simulation

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/c5a2d4e6-120d-4ee0-b131-e6b9db6b05c8)

![Screenshot from 2023-10-20 19-55-35](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/8ce6c566-5edb-40b7-9b19-a65c3236de17)

### Post Synthesis Simulation

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/6a1d4459-845c-4703-831b-189e5adc8a58)


![Screenshot from 2023-10-20 21-11-14](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/f0cb624d-1340-41c4-9c0b-cf1b921a4879)

</details>

# RTL2GDSII - OPENLANE

### Installing Openlane

The original Documentation can be found here [OpenLane Installation](https://openlane.readthedocs.io/en/latest/getting_started/installation/installation_ubuntu.html)

#### Installing the pre-requisites
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git
```

#### Uninstall conflicting packages of docker if present

```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

```

#### Install Docker using ```apt``` repository

1. Setup Docker's ```apt``` repository

```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Install other packages

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Verify that the Docker Engine installation is successful by running the ```hello-world``` image.

```
sudo docker run hello-world
```

A successfull installation would look like
```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub. (amd64)
3. The Docker daemon created a new container from that image which runs the executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
https://hub.docker.com/

For more examples and ideas, visit:
https://docs.docker.com/get-started/
```

5. Making Docker available without root (Linux)

```
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot # REBOOT!
```

6. Checking the docker installation after reboot

```
# After reboot
docker run hello-world
```

You will get a little happy message of Hello world, once again, but this time without root.

```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
   (amd64)
3. The Docker daemon created a new container from that image which runs the
   executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it
   to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
https://hub.docker.com/

For more examples and ideas, visit:
https://docs.docker.com/get-started/
```

### Checking Installation Requirements

```
git --version
docker --version
python3 --version
python3 -m pip --version
make --version
python3 -m venv -h
```

Successful output will look like this:

```
git --version
docker --version
python3 --version
python3 -m pip --version
make --version
python3 -m venv -h
git version 2.36.1
Docker version 20.10.16, build aa7e414fdc
Python 3.10.5
pip 21.0 from /usr/lib/python3.10/site-packages/pip (python 3.10)
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
usage: venv [-h] [--system-site-packages] [--symlinks | --copies] [--clear]
            [--upgrade] [--without-pip] [--prompt PROMPT] [--upgrade-deps]
            ENV_DIR [ENV_DIR ...]

Creates virtual Python environments in one or more target directories.
...
Once an environment has been created, you may wish to activate it, e.g. by
sourcing an activate script in its bin directory.
```

### Download and Install Openlane

Run these one after the other

```
git clone --depth 1 https://github.com/The-OpenROAD-Project/OpenLane.git
cd OpenLane/
make
make test
```

Successful test will output the following line:

```
Basic test passed
```

### Into The Workshop

Before starting the workshop, I would strongly suggest you to go through all the [Flow Configuration Variables](https://openlane.readthedocs.io/en/latest/reference/configuration.html), understand what they do and why they are required. This Will help reach the goal faster.

## Creating design folder through openlane

To create a design folder with a default config.json file, follow the below command

```
cd
cd OpenLane
make mount
./flow.tcl -design <YOUR_DESIGN_NAME_HERE> -init_design_config
```
![Screenshot from 2023-11-01 08-52-08](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/e16d064e-3ecd-48cc-99c3-a8a3d780b18a)


## Running a basic automated flow

- The errors encountered here helps to find the variables to be set in the ```config.json``` file inorder to resolve the error.
- The warning messages also gives an info of what extra variables to be defined in the json file
- By end of this automated flow without any error or flow related warnings after some iterations, You will have a proper populated config.json file
- This json file can be used to go on with interactive flow where you can change the variables in between the flow if required

The command to run the automated flow is 

```
./flow.tcl -design openlane/<YOUR_DESIGN_FLODER_NAME> -tag <ANY_NAME_FOR_EACH_RUN>
```

![Screenshot from 2023-11-03 10-51-14](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/722a4d95-de99-4edf-b8e7-436ac647a8fd)

Here we can observe a warning saying that the core area is too small and it set an area by itself. But we can specify the area by including the corresponding variable in the json file.

Some of the conditions for the design to work properly

- slack after synthesis should be as small as possible and a very small negative value such as -0.1 or below should be ok as after routing stage, the delay gets added and slack becomes positive
- if the design is core, then you may proceed with assigning more core utilisation upto 75%
- Make sure about the synthesis strategy

##### INFO

- The default variables that are used to run the deisgn can be viewed at ```OpenLane/openlane/runs/<SPECIFIC_RUN_FOLDER>/config.tcl```
- Once go through all the default values, paths etc used and decide on what to change for next run for the design to make it better
- The results regarding the slack can be found at ```OpenLane/openlane/runs/<SPECIFIC_RUN_FOLDER>/reports/synthesis```
 - AREA stat rpt has the statistics related to design area and cells used in synthesis
 - sta summary has the slack details
- The results related to die area and core area can be obtained at ```OpenLane/openlane/runs/<SPECIFIC_RUN_FOLDER>/reports/floorplan```
 - core area file has the co-ordinates of the core ```(x0 y0 x1 y1)``` bottom left corner, top right corner co ordinates
 - Die area file has the co-ordinates of Die
 - Module area in the synthesis folder observed will almost be half of the core area (x1-x0 * y1-y0). This is because the default core utilisation is 50%
 - Make it less by changing the co-ordinates of core area using the corresponding variable with a utilisation percent in target
 - core util = module area / core area

 Similarly explore all the other folders inside the <SPECIFIC_RUN_FOLDER>.

### Config.json

Once all the above suggestions are followed, the config.json for my file looks something like this but you may have different variables according to your design

- The cap load can be seen at the input pin of the driving cell defined in the library corresponding to ```LIB_SYNTH_COMPLETE```

![Screenshot from 2023-11-03 11-08-15](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/b37e1c46-ceb1-4a62-8101-208d6aa7b43f)

## Interactive flow 

The variables that can be changed for particular step of interactive flow can be found at ```OpenLane/configuratons``` in the form of <STAGE>.tcl

1. **Initiate the interactive flow** - ```./flow.tcl -interactive```
2. **prepare the design for the flow** - ```prep -design openlane/<DESIGN_FOLDER_NAME> -tag <RUN_NAME>```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/0e620091-5953-4324-9234-d958ca54edcf)

3. **Run Synthesis** - ```run_synthesis```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/8a459144-ee2d-46b8-ae16-c74801956f03)

- The area statistics results can be found at ```results/synthesis```
- The static timing analysis (slack) results can be seen at the bottom of ```logs/synthesis/2-sta.summary.rpt```

### NOTE

1. ##### If the slack is highly negative -0.1, -0.05, 0 etc proceed to next steps from run_floorplan
2. ##### If the slack is just positive, then continue with next steps from run_floorplan
3. ##### If the slack is higly positive, Greater than 2 then you have a scope to decrease the clock period and run again so that freqency increases.
4. ##### If the slack is -0.4 , 0.5 or lower, then increase the clock period
5. ##### If the slack is -0.4 to 0 then instead of directly increasing the clock period, try some OpenSTA optimisations so that we get positive slack at same frequency.

Here We have 2 ways to go
1. OpenSTA
2. Proceed with further flow from run_floorplan

### OpenSTA

We here do pre-STA analsysis where we 
- replace the cells that have more fanout to a cell with cell fanout
- replace the cell contributing to more delay with a cell that decreases it by a larger verion of it with same functionality
- check the slack for every action taken
- stop the process once the slack is either point 1 or 2 under the NOTE
- replace the synthesized verilog file with the sta operated verilog file
- proceed with main floe from run_floorplan

The process requires 
- OpenSTA - ```sudo apt install opensta```
- a config file for sta
- a base.sdc file that defines the constraints

#### Config file for STA

- create a file pre_sta.conf in ```OpenLane/openlane``` with the content

```
set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um
read_liberty -max /home/mdsabir/.volare/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
read_liberty -min /home/mdsabir/.volare/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v95.lib
read_liberty -nom /home/mdsabir/.volare/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog /home/mdsabir/OpenLane/openlane/bfloat_adder/runs/run1_inter/results/synthesis/bfloat_adder.v
link_design bfloat_adder
read_sdc /home/mdsabir/OpenLane/openlane/bfloat_adder/src/my_base.sdc
report_checks -path_delay min_max -fields {slew trans net cap input_pin}
report_tns
report_wns
```

- max library is the library corresponding to the path present at ```LIB_SLOWEST``` in the config.tcl file present in the runs/<SPECIFIC_RUN_FOLDER>
- min library is the library corresponding to the path present at ```LIB_FASTEST```
- nom library is the library corresponding to the path present at ```LIB_SYNTH_COMPLETE```
- my_base.sdc to be created in ```src``` folder with the content present at ```OpenLane/scripts/base.sdc``` and set the environment variables mentioned in ```base.sdc```

#### OpenSTA Flow

Go to the directory where pre_sta.conf is present and run ```sta pre_sta.conf```

The  Hold slack has met the requirement

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/b066b305-2e26-4c08-8f39-2442cb9ef0fe)

The setup slack didnt meet the requirement

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/706d653d-ab88-4a1c-9775-f37bae318d20)

##### STEP 1 : Decrease the Fanout - I did it to 4 

To the config.json file, add the line ``` "MAX_FANOUT_CONSTRAINT": 4,``` after the clock period variable and again start interactive flow from start, prepare design and overwrite the run, run_synthesis and then run the sta part

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/b129e011-a090-4036-aeb4-0566e02cdd5d)

Setup slack after this step

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/4e5cc20a-afed-4fe7-a1c0-6e9b7f6a4e8a)

##### STEP 2 : Replace cells that infer larger delay

In the above figure we can observe that cell instance **475** is causing the most delay. So we have to replace it with larger version of itself

```report_net -connections _035_``` - instances being driven by net _035_ as in fig

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/efaf4746-19cc-4d27-8f9a-b1444cc8eeb4)

The instance that's causing highest delay is the cell **475**. So replace it as mentioned and check the result

```
replace_cell _475_ sky130_fd_sc_hd__or2b_4
report_checks -path_delay min_max -fields {slew trans net cap input_pin}
```

repeat this till the slack reaches almost positive value or a minimum positive value

![Screenshot from 2023-11-03 18-08-41](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/4312651c-e85f-4da4-b6ff-b148b09d4ac6)

4. **Run Floorplan** - ```run_floorplan```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/ba3bcd58-8d37-4ed2-a64b-a3153c8954ad)

To view Floorplan in magic
```
cd /home/mdsabir/OpenLane/openlane/PES_ADD_SUB_32/runs/run1_inter/results/floorplan
magic -T /home/mdsabir/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read bfloat_adder.def &
```

change the paths accordingly for the runs and hostname

![Screenshot from 2023-11-03 18-14-26](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/e4e529a8-e817-4372-8982-c003effcee03)

5. **Run Placement** - ```run_placement```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/7d8c70c6-b8c0-49d1-b40a-79925b2cf112)

A snipshot of placement 

![Screenshot from 2023-11-03 18-15-43](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/562f2cde-5ca2-4dbb-93a5-2fdff4ceec59)

![Screenshot from 2023-11-03 18-17-42](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/6274992d-6122-4cc1-9e4d-b359f90da9dd)


Execute the same magic command as in floorplan stage but this time in ```results/placement``` folder

6. **Run CTS** - ```run_cts```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/b42a90f9-4f17-465d-a65a-7e487df18c42)

POWER AREA AND TIMING REPORT

![repo2](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/a1020f69-728a-4ae7-8402-157b62f7fb4d)


7. **Generate Power Distribution Network** - ```gen_pdn```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/d2e91a64-f7d8-4bc6-8bd2-841274c1975a)

8. **Run Routing** - ```run_routing```

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/76ec00fa-ba25-45df-8830-1add6953a5a4)

![Screenshot from 2023-11-03 18-20-46](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/0396fbc6-4e1d-4031-899d-504d09cfcb06)

![report](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/10bc8605-7e14-43b6-8983-5d2f8782c90c)

