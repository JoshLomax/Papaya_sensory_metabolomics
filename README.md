# Papaya Sensory Profile Metabolomics Analysis

[![Project Status](https://img.shields.io/badge/status-active-green)](https://img.shields.io/badge/status-active-green)
[![R Version](https://img.shields.io/badge/R-%3E%3D4.0.0-blue)](https://img.shields.io/badge/R-%3E%3D4.0.0-blue)
[![Last Updated](https://img.shields.io/badge/last%20updated-february%202024-yellowgreen)](https://img.shields.io/badge/last%20updated-february%202024-yellowgreen)

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Data Analysis Pipeline](#data-analysis-pipeline)
- [Analysis Methods](#analysis-methods)
- [Contributing](#contributing)
- [Licence](#licence)
- [Citation](#citation)
- [Contact](#contact)

## Overview
This project analyses the relationship between metabolites and sensory profiles in papaya fruits, focusing on taste and aroma characteristics. The analysis combines metabolomics data with sensory evaluation to identify key markers for fruit flavour selection in breeding programmes.

### Key Features
- Comprehensive metabolomic analysis of 27 papaya genotypes
- Integration of sensory evaluation data from trained panels
- Machine learning models for flavour prediction
- Statistical analysis of consumer preferences
- Metabolite concentration quantification
- Consumer preference analysis with 125 participants

## Project Structure
```bash
papaya-metabolomics/
├── data/
│   ├── July24_all.xlsx
│   ├── Results_22_23.xlsx
│   ├── GTR_data.xlsx
│   ├── all_sensory_data.xlsx
│   ├── consumer_data.xlsx
│   └── papaya_sample_meta_data.xlsx
├── style/
│   ├── header.html
│   ├── style.css
│   └── external-links-js.html
├── supp/
│   └── appendix2.pdf
└── R/
    └── analysis_scripts/
```

## Prerequisites
- R >= 4.0.0
- RStudio (recommended)
- Required R packages:

```bash
rmdformats, kableExtra, gt, flextable, DT
tidyverse, readxl, janitor, AMR
ggpmisc, ggthemes, ggrepel, geomtextpath, scales
FactoMineR, factoextra
car, agricolae, tableone, summarytools
BGLR, caret, gbm, xgboost, apcluster, lme4, emmeans
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/username/papaya-metabolomics.git
cd papaya-metabolomics
```

2. Install required R packages:
```bash
# In R console
install.packages("pacman")
pacman::p_load(rmdformats, kableExtra, gt, flextable, DT, tidyverse, readxl, janitor, AMR, 
               ggpmisc, ggthemes, ggrepel, geomtextpath, scales, FactoMineR, factoextra,
               car, agricolae, tableone, summarytools, BGLR, caret, gbm, xgboost, 
               apcluster, lme4, emmeans)
```

## Usage
1. Open the R project in RStudio
2. Run the main analysis script:
```bash
source('analysis_scripts/main.R')
```

## Data Analysis Pipeline
1. Data Preprocessing
   - VOC matrix effects calculation
   - Sugar extraction efficiency analysis
   - Data transformation and normalisation
   - Missing value imputation

2. Statistical Analysis
   - Principal Component Analysis (PCA)
   - Machine Learning Models
   - Sensory Profile Analysis

## Analysis Methods

### Sensory Analysis
- Trained panel evaluations using Quantitative Descriptive Analysis (QDA)
- Consumer panel with 125 participants
- Randomised complete block design
- Purpose-built sensory laboratory settings (22°C, LED daylight-equivalent lighting)

### Modelling Approaches
1. **Generalised Boosted Regression**
   - Captures main effects and interactions
   - 10-fold cross-validation optimisation
   - Implementation using GBM package

2. **Bayesian Linear Regression (BayesA)**
   - Estimates individual additive effects
   - No interaction terms
   - 30,000 iterations with 10,000 burn-in

### Consumer Analysis
- Demographic data collection
- Age distribution analysis
- Gender representation
- Consumption habit assessment
- Preference correlation studies

### Visualisation Methods
- Faceted plots for metabolite relationships
- PCA biplots for genotype clustering
- Consumer demographic distributions
- Variable importance plots

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## Licence
This project is licenced under the MIT Licence - see the [LICENCE](LICENCE) file for details.

## Citation
```bibtex
@article{lomaxMultiomicApplicationsUnderstanding2024,
  author = {Joshua Lomax and Ido Bar},
  doi = {10.5281/zenodo.15746218},
  publisher = {Zenodo},
  title = {JoshLomax/Papaya_sensory_metabolomics: Metabolomics analysis of Papaya sensory profiles (Version V1)},
  url = {https://doi.org/10.5281/zenodo.15746218},
  year = {2025}
}
```

## Contact
- **Josh Lomax** - [GitHub Profile](https://github.com/JoshLomax)
- **Ido Bar** - [GitHub Profile](https://github.com/IdoBar)

Project Link: [https://github.com/username/papaya-metabolomics](https://github.com/username/papaya-metabolomics)

---
Last Updated: June 2025