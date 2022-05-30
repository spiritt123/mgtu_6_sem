pkg load signal
pkg load communications
% Моделирование звуковых сигналов
clear all; % Очистка памяти
close all; % Закрытие всех окон с графиками
clc; % Очистка окна команд и сообщений
fontSize=10; % Размер шрифта графиков
fontType=''; % Тип шрифта графиков
% Цвет графиков
tColor=[0,0.447,0.741]; % Временная область
tColorLight=[0.3 0.7 0.9]; % Временная область
Color0=[1 0 0]; % Эталонные сигналы
fColor=[1 0.4 0]; % Частотная область
eColor=[0.85 0.325 0.098]; % Погрешности
eColorLight=[0.9 0.9 0.4]; % Погрешности
eColorDark=[0.635 0.078 0.184]; % Погрешности
fd=1025; % Частота дискретизации
Td=1/fd; % Период дискретизации
snrSound=3; % Уровень шума, дБ
% Длительности нот
t01=0:Td:.03-Td; % 0.03 с
t05=0:Td:.5-Td; % 0.5 с
t07=0:Td:.7-Td; % 0.7 с
t09=0:Td:.9-Td; % 0.9 с
t10=0:Td:2-Td; % 1.0 с
t15=0:Td:1.5-Td; % 1.5 с
t30=0:Td:3-Td; % 3.0 с
% Определение обозначений для нот
Z_t10(1:length(t10))=0; % пауза 1 с
Z_t_cust(1:length(t01))=0; % пауза 0.03 с
% Частоты нот первой октавы
A4=440.000; % частота ноты ЛЯ,Гц
C4=A4*2^ (-9/12); % частота ноты ДО,Гц
D4=A4*2^ (-7/12); % частота ноты РЕ,Гц
D4d=A4*2^ (-6/12); % частота ноты РЕ#,Гц
E4=A4*2^ (-5/12); % частота ноты МИ,Гц
F4=A4*2^ (-4/12); % частота ноты ФА,Гц
G4=A4*2^ (-2/12); % частота ноты СОЛЬ,Гц
A4=A4*2^ ( 0/12); % частота ноты ЛЯ,Гц
B4=A4*2^ ( 2/12); % частота ноты СИ,Гц
getNote = @(frq,dur) sin(2*pi* dur * frq);%(440*2.^((frq-1)/12)));
% Формирование нотной последовательности
gamma_notes=[Z_t10,getNote(C4,t10),Z_t10,getNote(D4,t10),Z_t10,...
getNote(E4,t10),Z_t10,getNote(F4,t10),Z_t10,getNote(G4,t10),...
Z_t10,getNote(A4,t10),Z_t10,getNote(B4,t10),Z_t10];
T_gamma=length(gamma_notes); % Длительность музыкального ряда
% Формирование сигнала нотной последовательности во временной области
xtime=linspace(0,T_gamma/fd,T_gamma); % Область определения
% Формирование графика
figure; plot(xtime,gamma_notes,'Color',tColor);
saveas(gcf,'figure_0','epsc')
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Звуковой ряд первой октавы'}); % Заголовок
xlabel ('Время,\it nT_д\rm,с'); % Надпись оси абсцисс
ylabel('Уровень громкости'); % Надпись оси ординат
yticks([]); % Нет значений на оси ординат
% Формирование спектра мощности
[fpNotes,freq]=periodogram(gamma_notes,rectwin(length(gamma_notes)),...
length(gamma_notes),fd,'power'); % Формирование значений
% Формирование графика
figure; plot(freq,fpNotes,'Color',fColor);
saveas(gcf,'figure_1','epsc')
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Спектр мощности звукового ряда первой октавы'}); % Заголовок
xlabel('Частота,\it f\rm,Гц'); % Надпись оси абсцисс
ylabel('Мощность'); % Надпись оси ординат
yticks([]); % Нет значений на оси ординаn
% Проигрывание гаммы
% sound(gamma_notes,fd); <===================================== MUSIC
% % Запись мелодии в WAV-файл
audiowrite('gamma.wav',gamma_notes,fd);
disp('Нажмите любую клавишу для продолжения...');
pause; % Пауза перед следующей мелодией
close all; % Закрытие всех окон с графиками
% Формирование шума нотной последовательности
ngamma_notes=awgn(gamma_notes,snrSound);
ngamma_notes=ngamma_notes/max(ngamma_notes);
% Формирование графика
figure; plot(xtime,ngamma_notes,'Color',tColor);
saveas(gcf,'figure_2','epsc')
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Зашумленный звуковой ряд'}); % Заголовок
xlabel ('Время,\it nT_д\rm,с'); % Надпись оси абсцисс
ylabel('Уровень громкости'); % Надпись оси ординат
yticks([]); % Нет значений на оси ординат
% Формирование спектра мощности
[fpnNotes,freq]=periodogram(ngamma_notes,rectwin(length(ngamma_notes)),...
length(ngamma_notes),fd,'power'); % Формирование значений
% Формирование графика
figure; plot(freq,fpnNotes,'Color',fColor);
saveas(gcf,'figure_3','epsc')
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Спектр мощности зашумленного звукового ряда'}); % Заголовок
xlabel('Частота,\it f\rm,Гц'); % Надпись оси абсцисс
ylabel('Мощность'); % Надпись оси ординат
yticks([]); % Нет значений на оси ординат
% Формирование спектрограммы звукового ряда
%figure; spectrogram(ngamma_notes,256,0,[],fd);
figure; specgram(ngamma_notes,256,fd);
saveas(gcf,'figure_4','epsc');
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Спектрограмма зашумленного звукового ряда'}); % Заголовок
% Проигрывание гаммы
% sound(ngamma_notes,fd); <===================================== MUSIC
% Запись мелодии в WAV-файл
audiowrite('ngamma.wav',ngamma_notes,fd);
disp('Нажмите любую клавишу для продолжения...');
pause; % Пауза перед следующей мелодией
close all;
% Формирование массива-мелодии "В траве сидел кузнечик"
sw_notes=[getNote(A4,t05), Z_t_cust,getNote(E4,t05),
Z_t_cust,getNote(A4,t05), Z_t_cust,getNote(E4,t05), Z_t_cust,...
getNote(A4,t05), Z_t_cust,... % Ля Ми Ля Ми Ля
getNote(G4,t05), Z_t_cust,getNote(G4,t05),
Z_t_cust,getNote(G4,t05), Z_t_cust,getNote(A4,t05), Z_t_cust,...
getNote(G4,t05), Z_t_cust,getNote(A4,t05),
Z_t_cust,getNote(G4,t05), Z_t_cust,... % Соль х3 - Ми - Соль - Ми - Соль
getNote(A4,t05), Z_t_cust,getNote(A4,t05),
Z_t_cust,getNote(A4,t05), Z_t_cust,getNote(E4,t05),
Z_t_cust,... % Ля х3 - Ми
getNote(A4,t05), Z_t_cust,getNote(E4,t05),
Z_t_cust,getNote(A4,t05), Z_t_cust,... % Ля Ми Ля
getNote(G4,t05), Z_t_cust,getNote(A4,t05),
Z_t_cust,getNote(G4,t05), Z_t_cust,... % Соль х3 - Ми - Соль - Ми - Соль
getNote(A4,t05), Z_t_cust,getNote(A4,t05),
Z_t_cust,getNote(B4,t05), Z_t_cust,getNote(B4,t05), Z_t_cust,...
getNote(B4,t05), Z_t_cust,getNote(B4,t05), Z_t_cust,... % Ля х2 - Си х4
getNote(C4,t05), Z_t_cust, getNote(C4,t05), Z_t_cust,...
getNote(C4,t05), Z_t_cust, getNote(C4,t05), Z_t_cust,...
getNote(C4,t05), Z_t_cust, getNote(C4,t05), Z_t_cust,... % До х6
getNote(B4,t05), Z_t_cust, getNote(A4,t05), Z_t_cust,...
Z_t_cust,getNote(G4,t05), getNote(A4,t05), Z_t_cust,...
getNote(A4,t05), Z_t_cust, getNote(A4,t05), Z_t_cust,...
getNote(A4,t05), Z_t_cust,...% Си - Ля - Си х5
getNote(C4,t05), Z_t_cust, getNote(C4,t05), Z_t_cust,...
getNote(C4,t05), Z_t_cust, getNote(C4,t05), Z_t_cust,...
getNote(C4,t05), Z_t_cust, getNote(C4,t05), Z_t_cust,... % До х6
];
figure; specgram(sw_notes,256,fd);
saveas(gcf,'figure_5','epsc');
set(get(gcf,'CurrentAxes'),'FontSize',fontSize);
% Проигрывание мелодии
sound(sw_notes,fd); %<=====================================MUSIC
% Запись мелодии в WAV-файл
audiowrite('melody.wav',sw_notes,fd);

