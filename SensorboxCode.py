import time
import board
import analogio
import digitalio
import neopixel
import adafruit_ahtx0
import wifi
import socketpool
import adafruit_requests

# --- Configuration ---
WIFI_SSID = ""
WIFI_PASS = ""
THINGSPEAK_KEY = ""
THINGSPEAK_URL = "http://api.thingspeak.com/update"

# --- Hardware Setup ---
photocell = analogio.AnalogIn(board.A1)
pir = digitalio.DigitalInOut(board.D13)
pir.direction = digitalio.Direction.INPUT

pixel_pin = board.A3
num_pixels = 8
pixels = neopixel.NeoPixel(pixel_pin, num_pixels, brightness=0.3, auto_write=False)

i2c = board.I2C()
sensor = adafruit_ahtx0.AHTx0(i2c)

# --- Network Setup ---
print("Connecting to WiFi...")
try:
    wifi.radio.connect(WIFI_SSID, WIFI_PASS)
    pool = socketpool.SocketPool(wifi.radio)
    requests = adafruit_requests.Session(pool)
    print("Connected to WiFi!")
except Exception as e:
    print("Could not connect to WiFi:", e)

# --- Variables for Timing ---
last_thingspeak_update = 0
update_interval = 20  # ThingSpeak free tier needs ~15-20 seconds between posts
old_pir_value = False

print("Starting main loop...")
motion_latched = 0

while True:
    current_pir = pir.value

    # If motion is detected AT ALL, latch it to 1
    if current_pir:
        pixels.fill((255, 0, 0))
        motion_latched = 1  # Remember that motion happened!
    else:
        pixels.fill((0, 255, 0))

    pixels.show()

    # --- ThingSpeak Update Logic ---
    current_time = time.monotonic()
    if current_time - last_thingspeak_update >= update_interval:

        temp = sensor.temperature
        humid = sensor.relative_humidity
        light = (photocell.value / 65535) * 100

        # Use the LATCHED value, not the live value
        data_url = (
            f"{THINGSPEAK_URL}?api_key={THINGSPEAK_KEY}"
            f"&field1={temp:.1f}&field2={humid:.1f}"
            f"&field3={motion_latched}&field4={light:.1f}"
        )

        try:
            response = requests.get(data_url)
            print(f"Sent to ThingSpeak. Motion was: {motion_latched}")
            response.close()

            # CRITICAL: Reset the latch for the next 20-second window
            motion_latched = 0

        except Exception as e:
            print("Error:", e)

        last_thingspeak_update = current_time

    time.sleep(0.1)
# Write your code here :-)
