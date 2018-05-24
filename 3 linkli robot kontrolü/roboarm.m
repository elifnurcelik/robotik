%3 DOF robot kolun ileri kinematik denklemler yard�m�yla joint a��lar�na
% g�re �al��mas�n� sim�le etmek.

% A��lar� giriniz.
fprintf('Q1,  Q2,  Q3 a��lar�n� giriniz\n');
% t1, t2, t3 jointlerin a�� parametreleri.
t1 = input('');
t2 = input('');
t3 = input('');

% 3 linkli  jointlerin ba�lang�� koordinatlar�
x = [0 2 4 6];
y = [0 0 0 0];

% Robot kolun ba�lang�� pozisyonu i�in jointleri �iz
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

% Eksenler i�in �l�eklendirme
axis([-7 7 -7 7]);

% Jointlerin a��lar�na g�re x eksenindeki s�n�rlar�

t1 = t1 * (pi / 180);
t2 = t2 * (pi / 180);
t3 = t3 * (pi / 180);

% �nceki ve sonraki x eksenleri aras�ndaki a��lar theta ile g�sterilir.
theta1 = t1;
theta2 = t2;
theta3 = t3;

theta = theta1 * theta2 * theta3;

% A��lar�n negatif de�erleri i�in
if theta < 0
    theta = -theta;
end

%  Sim�lasyon i�in bir for d�ng�s� �al��t�rma

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
    %  Link uzunlar� parametreleri
    T2 = Translate(2);
    T3 = Translate(2);
    T4 = Translate(2);

    %  �kinci nokta bulma
    %  Transformation matrisi
    Y = R1 * T2;
    
    % Yeni koordinatlar� bulma
    Y1 = Y * [0; 0; 0; 1];
    x(2) = Y1(1);
    y(2) = Y1(2);

    % ���nc� nokta bulma
    % Transformation matrisi
    Y = R1 * T2 * R2 * T3;
    
    %  Yeni koordinatlar� bulma
    Y1 = Y * [0; 0; 0; 1];
    x(3) = Y1(1);
    y(3) = Y1(2);

    % D�rd�nc� nokta bulma
    % Transformation matrix
    Y = R1 * T2 * R2 * T3 * R3 * T4;
    
    % Yeni koordinatlar� bulma
    Y1 = Y * [0; 0; 0; 1];
    x(4) = Y1(1);
    y(4) = Y1(2);
    
    % Bir sonraki �izgi �izilece�i zaman g�r�lmeyecek �ekilde �nceden
    % �izilmi� olan �izgiyi sil.
    
    delete(l);
    delete(l5);
    delete(l6);
    delete(l7);
    delete(l8);
    % Eksenleri d�zelt ve �izgi �iz.
    
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