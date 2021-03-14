% Импортируйте данные из csv-файлов
spectra     = importdata('spectra.csv');
starNames   = importdata('star_names.csv');
lambdaStart = importdata('lambda_start.csv');
lambdaDelta = importdata('lambda_delta.csv');
% Определите константы
lambdaPr = 656.28; %нм
speedOfLight = 299792.458; %км/c
nObs      = size(spectra, 1);
nOsi      = size(starNames, 1);
lambdaEnd = lambdaStart + (nObs - 1) * lambdaDelta;
lambda    = (lambdaStart : lambdaDelta : lambdaEnd)';
% Определите диапазон длин волн
s          = spectra(:, nOsi);
[sHa, idx] = min(spectra);
lambdaHa   = lambda(idx);
% Рассчитайте скорости звезд относительно Земли
z     = (lambdaHa / lambdaPr) - 1 ;
speed = z * speedOfLight ;
movaway = starNames(speed > 0);
% Постройте график
fg1 = figure;
for k = 1:nOsi
    if speed(k) < 0
       plot(lambda, spectra(:, k), '--', 'Linewidth', 1); 
    elseif speed(k) > 0
        plot(lambda, spectra(:, k), '-', 'Linewidth', 3);
    end
    set(fg1, 'visible', 'on');
    hold on;
end
grid on;
legend(starNames);
xlabel('Длина волны, нм');
ylabel(['Интенсивность, эрг/см^2/c/', char(197)]);
title('Спектры звезд');
text(635, 3.2*10^(-13),'Даниил Талашкевич, Б01-009');
% Сохраните график
saveas(fg1, 'spectra', 'png');
