%3 DOF robot kolun ileri kinematik denklemler yardýmýyla joint açýlarýna
% göre çalýþmasýný simüle etmek.

% Açýlarý giriniz.
fprintf('Q1,  Q2,  Q3 açýlarýný giriniz\n');
% t1, t2, t3 jointlerin açý parametreleri.
t1 = input('');
t2 = input('');
t3 = input('');

% 3 linkli  jointlerin baþlangýç koordinatlarý
x = [0 2 4 6];
y = [0 0 0 0];

% Robot kolun baþlangýç pozisyonu için jointleri çiz
grid on;
l = line(x, y);
hold on;
l1 = plot(x(1), y(1), '-');
l2 = plot(x(2), y(2), '-');
l3 = plot(x(3), y(3), '-');
l4 = plot(x(4), y(4), '-');
l5 = plot(x(1), y(1), 's');
l6 = plot(x(2), y(2), 's');
l7 = plot(x(3), y(3), 's');
l8 = plot(x(4), y(4), 's');

% Eksenler için ölçeklendirme
axis([-7 7 -7 7]);

% Jointlerin açýlarýna göre x eksenindeki sýnýrlarý

t1 = t1 * (pi / 180);
t2 = t2 * (pi / 180);
t3 = t3 * (pi / 180);

% Önceki ve sonraki x eksenleri arasýndaki açýlar theta ile gösterilir.
theta1 = t1;
theta2 = t2;
theta3 = t3;

theta = theta1 * theta2 * theta3;

% Açýlarýn negatif deðerleri için
if theta < 0
    theta = -theta;
end

%  Simülasyon için bir for döngüsü çalýþtýrma

for i = 0 : 0.01 : theta
    
    tt1 = (i * theta1) ./ (theta);
    tt2 = (i * theta2) ./ (theta);
    tt3 = (i * theta3) ./ (theta);

    % Transformasyon matrisleri
    %  Rotasyon matrisleri
    R1 = Rotate(tt1);
    R2 = Rotate(tt2);
    R3 = Rotate(tt3);

    % Translation matrisleri
    %  Link uzunlarý parametreleri
    T2 = Translate(2);
    T3 = Translate(2);
    T4 = Translate(2);

    %  Ýkinci nokta bulma
    %  Transformation matrisi
    Y = R1 * T2;
    
    % Yeni koordinatlarý bulma
    Y1 = Y * [0; 0; 0; 1];
    x(2) = Y1(1);
    y(2) = Y1(2);

    % Üçüncü nokta bulma
    % Transformation matrisi
    Y = R1 * T2 * R2 * T3;
    
    %  Yeni koordinatlarý bulma
    Y1 = Y * [0; 0; 0; 1];
    x(3) = Y1(1);
    y(3) = Y1(2);

    % Dördüncü nokta bulma
    % Transformation matrix
    Y = R1 * T2 * R2 * T3 * R3 * T4;
    
    % Yeni koordinatlarý bulma
    Y1 = Y * [0; 0; 0; 1];
    x(4) = Y1(1);
    y(4) = Y1(2);
    
    % Bir sonraki çizgi çizileceði zaman görülmeyecek þekilde önceden
    % çizilmiþ olan çizgiyi sil.
    
    delete(l);
    delete(l5);
    delete(l6);
    delete(l7);
    delete(l8);
    % Eksenleri düzelt ve çizgi çiz.
    
    l = line(x, y);
    hold on;
    l1 = plot(x(1), y(1), 'r.');
    l2 = plot(x(2), y(2), 'r.');
    l3 = plot(x(3), y(3), 'r.');
    l4 = plot(x(4), y(4), 'ro');
    l1.MarkerSize = 1;
    l2.MarkerSize = 1;
    l3.MarkerSize = 1;
    l4.MarkerSize = 5;
    l5 = plot(x(1), y(1), 'gs');
    l6 = plot(x(2), y(2), 'gs');
    l7 = plot(x(3), y(3), 'gs');
    l8 = plot(x(4), y(4), 'gs');
    axis([-7 7 -7 7]);
    pause(0.01);
end