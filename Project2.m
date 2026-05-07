%% ECEG 100: Multi-Channel Data Plotting with Averages
% --- Configuration ---
tempChannelID = ;    %insert channel ID  
tempField = ;        %insert feild        
humidChannelID = ;      
humidField = ;               

% --- 1. Define the Time Window ---
% This ensures both sensors are compared over the same period
endTime = datetime('now');
startTime = endTime - days(3); % Adjust this number to see more/less history

% --- Temporary Check: Read by points instead of date ---
[tempData, tempTime] = thingSpeakRead(tempChannelID, 'Fields', tempField, ...
    'NumPoints', 100, 'OutputFormat', 'matrix');

[humidData, humidTime] = thingSpeakRead(humidChannelID, 'Fields', humidField, ...
    'NumPoints', 100, 'OutputFormat', 'matrix');

% --- 3. Create Combined Plot ---
figure(1)
clf; 

% --- Plot Temperature (Left Axis) ---
yyaxis left
plot(tempTime, tempData, '-r', 'LineWidth', 1.5) 
ylabel('Temperature (Degrees F)')
hold on; 

% Add Temperature Average Line
avgTemp = mean(tempData, 'omitnan');
yline(avgTemp, '--r', 'Alpha', 0.7, 'LineWidth', 1.2, ...
    'Label', ['Avg: ' num2str(round(avgTemp,1))], 'LabelHorizontalAlignment', 'left');

% --- Plot Humidity (Right Axis) ---
yyaxis right
plot(humidTime, humidData, '-b', 'LineWidth', 1.5) 
ylabel('Humidity (%)')

% Add Humidity Average Line
avgHumid = mean(humidData, 'omitnan');
yline(avgHumid, '--b', 'Alpha', 0.7, 'LineWidth', 1.2, ...
    'Label', ['Avg: ' num2str(round(avgHumid,1))], 'LabelHorizontalAlignment', 'right');

% --- 4. Final Formatting ---
title('3-Day Temperature and Humidity Comparison')
xlabel('Time')
grid on
legend('Temperature', 'Temp Avg', 'Humidity', 'Humid Avg', 'Location', 'best')

% --- 5. Session Averages (Command Window) ---
fprintf('\n--- Session Averages ---\n');
fprintf('Average Temperature: %.2f F\n', avgTemp);
fprintf('Average Humidity:    %.2f %%\n', avgHumid);
fprintf('--------------------------\n');

% --- 1. Pick a specific day that has data for BOTH (April 30th) ---
startTime = datetime(2026, 4, 27, 0, 0, 0);
endTime = datetime(2026, 4, 27, 23, 59, 59);

% --- 2. Read both channels for that specific day ---
[tempData, tempTime] = thingSpeakRead(tempChannelID, 'Fields', tempField, ...
    'DateRange', [startTime, endTime], 'OutputFormat', 'matrix');

[humidData, humidTime] = thingSpeakRead(humidChannelID, 'Fields', humidField, ...
    'DateRange', [startTime, endTime], 'OutputFormat', 'matrix');

