# Embedded-Sensor-Box
# 📦 Embedded Sensor Box

An IoT sensor box built with an ESP32 that monitors environmental and physical data — including temperature, humidity, light, and motion — and streams it live to ThingSpeak for cloud-based visualization. MATLAB is used to pull that data and generate graphs for analysis.

---

## 🔧 Technologies

- CircuitPython
- MATLAB
- ThingSpeak

---

## 🛠️ Hardware Components

- ESP32 (microcontroller)
- AHT20 (temperature & humidity sensor)
- Photoresistor (light sensor)
- PIR Motion Sensor
- 8 LED NeoPixel strip

---

## ✨ Features

Here's what the Embedded Sensor Box does:

- **Temperature & Humidity Monitoring:** Uses the AHT20 sensor to continuously read and log ambient temperature and humidity levels.
- **Light Detection:** A photoresistor measures the current light level in the environment.
- **Motion Detection:** A PIR sensor detects movement. When motion is detected, the 8 LED NeoPixel strip lights up as a visual indicator.
- **Cloud Data Streaming:** All sensor readings are sent to ThingSpeak in real time via CircuitPython, where they are displayed on live dashboards.
- **MATLAB Graphing:** MATLAB pulls the ThingSpeak data and generates graphs, allowing for deeper analysis and visualization of sensor trends over time.

---

## ⚙️ The Process

I started by getting the ESP32 set up with CircuitPython and wiring up each sensor one at a time. First I got the AHT20 reading temperature and humidity, then added the photoresistor for light levels, and then the PIR sensor for motion detection.

Once all the sensors were reading data, I connected the NeoPixel strip and wrote the logic to light it up whenever the PIR sensor detected motion — giving a clear physical feedback signal.

After getting everything working locally, I focused on sending the data to the cloud. I configured CircuitPython to push the sensor readings to ThingSpeak over Wi-Fi, where the data appears on live channel dashboards.

Finally, I worked in MATLAB to connect to the ThingSpeak API, retrieve the stored sensor data, and create plots and graphs to visualize changes over time.

---

## 📚 What I Learned

During this project, I picked up a lot of practical skills working at the intersection of hardware and software.

### 🔌 CircuitPython & Hardware:
- **Sensor Integration:** I learned how to wire and read from multiple sensors simultaneously on a single microcontroller, and how to manage the data each one produces.
- **NeoPixel Control:** I learned how to control individually addressable LEDs and trigger them based on real sensor events.

### ☁️ Cloud & IoT:
- **ThingSpeak Integration:** I learned how to configure CircuitPython to send data over Wi-Fi to a cloud platform, and how to structure data into channels for clean display.

### 📊 MATLAB & Data Analysis:
- **Reading API Data:** I learned how to connect MATLAB to ThingSpeak's API and pull live sensor data into scripts for processing.
- **Data Visualization:** I practiced creating graphs in MATLAB from real-world data, which helped me better understand how to read and interpret sensor trends.

### 💡 Overall Growth:


Each part of this project helped me grow as both a programmer and an engineer. The biggest challenge I faced was getting ThingSpeak to connect and successfully receive data from the ESP32 — it took a lot of troubleshooting before it clicked. After that, pulling the ThingSpeak data into MATLAB and getting it to display correctly as graphs was another steep learning curve, since I had to understand how the two platforms communicate with each other.


Beyond the software side, I came away with a much stronger understanding of circuits in general. Working hands-on with multiple sensors, wiring them together, and debugging connection issues gave me a practical foundation I didn't have before this project.

---

## ❓ How Can It Be Improved?

- **Larger Enclosure:** The physical box felt cramped with all the sensors inside. A larger housing would make it easier to organize the components and add more sensors in the future.
- **More Accurate Photoresistor:** The current photoresistor works but isn't the most precise. Swapping it for a higher quality light sensor would give more reliable and consistent light level readings.
- **More Accurate Motion Sensor:** The PIR sensor occasionally triggered false positives. A more accurate motion sensor would improve the reliability of motion detection and make the NeoPixel feedback more trustworthy.

---

## 🚀 Running the Project

To run this project:

1. Wire up all components to the ESP32 according to the circuit schematic.
2. Install CircuitPython on the ESP32 and copy the project code onto the device.
3. Update the `SensorboxCode.py` file with your Wi-Fi credentials and ThingSpeak API key.
4. Power the ESP32 — it will begin reading sensors and pushing data to ThingSpeak automatically.
5. Open your ThingSpeak channel to view live data, or run the MATLAB script to generate graphs from the stored data.
