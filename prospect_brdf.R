library(prospect)
library(ggplot2)

# Default PROSPECT simulation
LRT_default <- PROSPECT()
# Simulate over the full spectral domain
LRT_default <- PROSPECT(SpecPROSPECT = prospect::SpecPROSPECT_FullRange)

# Run PROSPECT with user-defined parameters over the 400-2500 nm range
LRT_VSWIR <- PROSPECT(N = 1.4, CHL = 30, CAR = 6, EWT = 0.02, LMA = 0.01)

# Define the spectral range for simulations in the VNIR from 400 to 1000 nm
wvlRange <- seq(400, 1000)
# Adjust spectral properties used in PROSPECT to VNIR domain
Adjust_VNIR <- FitSpectralData(lambda = wvlRange)
LRT_VNIR <- PROSPECT(SpecPROSPECT = Adjust_VNIR$SpecPROSPECT,
                     N = 1.4, CHL = 30, CAR = 6, EWT = 0.02, LMA = 0.01)

# Correcting errors in LRT_confusion_version by setting LMA to 0
LRT_confusion_version <- PROSPECT(CHL = 45, CAR = 10, ANT = 0.2, EWT = 0.012, 
                                  LMA = 0, PROT = 0, N = 1.3)

# LRT_D (Fixed LMA to a correct value for physical accuracy)
LRT_D <- PROSPECT(CHL = 45, CAR = 10, ANT = 0.2, EWT = 0.012, LMA = 0.01, N = 1.3)

# Check the structure of LRT_D
str(LRT_D)

# Plotting the result of LRT_D
# Extract the reflectance data from LRT_D
reflectance_data <- LRT_D$Reflectance   # Use the correct column name here
wavelengths <- LRT_D$wvl   # Use the wavelength data directly from LRT_D

# Create a data frame for plotting
df <- data.frame(Wavelength = wavelengths, Reflectance = reflectance_data)

# Plot using ggplot2
ggplot(df, aes(x = Wavelength, y = Reflectance)) +
  geom_line(color = "blue") +
  labs(title = "Reflectance vs Wavelength (LRT_D)", x = "Wavelength (nm)", y = "Reflectance") +
  theme_minimal()
