# Power Loss Estimation of a Two-Level Three-Phase Inverter

This repository contains the MATLAB implementation developed for the
estimation of semiconductor power losses in a conventional two-level
three-phase voltage source inverter.

The developed algorithm evaluates the main semiconductor loss components
in the inverter power switches, including:

- IGBT conduction losses;
- Diode conduction losses;
- IGBT turn-on switching losses;
- IGBT turn-off switching losses;
- Diode reverse-recovery losses.

The estimated semiconductor power losses are used as input data for the
thermal analysis of an inverter power module presented in the associated
publication.

The code implements an analytical loss estimation approach based on
semiconductor datasheet characteristics and switching conditions.


## Repository Structure

```text
PowerLossEstimation/
│
├── README.md
│
├── MATLAB/
│   ├── PowerLossEstimation.m
│   ├── CondLoss2Lzam.m
│   ├── PonLoss2Lzam.m
│   ├── PoffLoss2Lzam.m
│   ├── PrecLoss2Lzam.m
│   ├── VcmdInv2Lzam.m
│   └── triangzam.m
│
└── Figures/
    └── PowerLosses.png
```


## Requirements

The code was developed and tested using:

- MATLAB R2025b

No additional MATLAB toolboxes are required.


## Running the Simulation

To reproduce the power loss estimation results:

1. Add the `MATLAB` folder to the MATLAB path.

2. Open the main script:

```text
PowerLossEstimation.m
```

3. Run the script.

The simulation generates the semiconductor power losses and the graphical
results used in the associated publication.


## Algorithm Overview

The implemented methodology consists of the following steps:

1. Generation of the triangular carrier waveform for sinusoidal pulse
   width modulation (SPWM).

2. Generation of the gate command signals for the two-level inverter
   phase-leg.

3. Evaluation of semiconductor conduction states according to the
   instantaneous load current and switching states.

4. Calculation of switching losses based on semiconductor datasheet
   characteristics, including:

   - turn-on energy losses;
   - turn-off energy losses;
   - reverse-recovery energy losses.

5. Calculation of the average power losses over one fundamental period.


## Associated Publication

L. M. Abdalla, P. H. Conrado, A. R. Rauber, L. R. Colpo,
F. Bruschi, and D. A. B. Zambra,

"Modeling and Analysis of a Liquid-Cooled Heat Sink for Inverters Used in
Hybrid Electric Vehicles"

IEEE Latin America Transactions.


## Citation

If you use this code in academic work, please cite the associated
publication:

L. M. Abdalla, P. H. Conrado, A. R. Rauber, L. R. Colpo,
F. Bruschi, and D. A. B. Zambra,

"Modeling and Analysis of a Liquid-Cooled Heat Sink for Inverters Used in
Hybrid Electric Vehicles"

IEEE Latin America Transactions.

DOI: To be added after publication.


## Author

**Diorge Alex Bao Zambra**

Instituto Hercílio Randon (IHR)  
Federal University of Rio Grande do Sul (UFRGS)


## Acknowledgment

The author acknowledges the support from Instituto Hercílio Randon (IHR)
and Federal University of Rio Grande do Sul (UFRGS) during the development
of this work.


## License

This project is distributed under the MIT License.

See the `LICENSE` file for more information.