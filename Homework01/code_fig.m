%% Housekeeping
clear all; clc; close all; 

global c
myColors();

%% Import data from spreadsheet
opts = spreadsheetImportOptions("NumVariables", 6);

% Specify sheet and range
opts.Sheet = "Aggregate";
opts.DataRange = "A2:F23";

% Specify column names and types
opts.VariableNames = ["Ciudad", "MinWageGrowth", "Inflation", "InformalityRate",'IPC','InfG'];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "Ciudad", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Ciudad", "EmptyFieldRule", "auto");

% Import the data
tbl = readtable("Data/Data.xlsx", opts, "UseExcel", false);

%% Convert to output type
cty     = tbl.Ciudad;
mW_g    = tbl.MinWageGrowth;
pi      = tbl.Inflation;
infR    = tbl.InformalityRate;
ipc     = tbl.IPC;
infG    = tbl.InfG;
clear opts tbl

%% 

lm  = fitlm(mW_g-pi,infR);
lmf = predict(lm,mW_g-pi);
lm2 = fitlm(mW_g-pi,infG);
lmf2 = predict(lm2,mW_g-pi);



figure;
hold on 
scatter(mW_g-pi,infR,'MarkerFaceColor',c.maroon,'MarkerEdgeColor','k')
plot(mW_g-pi,lmf,'k')
xlabel('Min. Wage Growth (Real)')
ylabel('Informality')
xticklabels(strcat(string(xticks()*100),'%'))
yticklabels(strcat(string(yticks()*100),'%'))
export_fig('Figures/infWage_static','-pdf','-transparent')


figure;
hold on 
scatter(mW_g-pi,infG,'MarkerFaceColor',c.maroon,'MarkerEdgeColor','k')
plot(mW_g-pi,lmf2,'k')
xlabel('Min. Wage Growth (Real)')
ylabel('Informality (Growth)')
xticklabels(strcat(string(xticks()*100),'%'))
yticklabels(strcat(string(yticks()*100),'%'))
export_fig('Figures/infWage_g','-pdf','-transparent')



