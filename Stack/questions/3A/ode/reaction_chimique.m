%on nettoie l'espace de travail d'Octave
clear 
%{
On considere l'equation differentielle associee a la reaction chimique:
k1: A --> B
k2: B --> C 
k3: B -->A
ou k1,k2,k3 sont les constantes cinetiques des reactions associees.

En notant a,b,c les concentrations de A,B et C, l'ODE se met sous la forme:

    a'(t) = -k1 a(t) + k3 b(t)
    b'(t) =  k1 a(t) - k2 b(t) - k3 b(t)      (**)
    c'(t) =  k2 b(t) 
%}

%constante de cinetique chimique
k1=1;
k2=2;
k3=3;
%matrice M qui definie l'equation differentielle (**)
global M
M=[-k1,k3,0;k1,-k2-k3,0;0,k2,0];

%condition initiale
y0 = [1,0,0]';
%temps final (borne sup de l'intervalle de resolution)
T = 10;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode lsode de Octave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%second membre de l'equation differentielle a resoudre: y'(t)=f(y(t),t)
function res = f(y,t)
  %constante de cinétique chimique, on recupere les variables definie ci-dessus
  global M
  %valeur de retour de la fonction f: ici c'est un vecteur de dim 3
  res = M*y; 
endfunction

%creation de la subdivision en temps
tn = linspace(0,T,100);
%appel de la routine lsode de Octave
[ysol,~,~] = lsode("f",y0,tn);

%on affiche les solutions
figure(1)
hold on
plot(tn,ysol(:,1),'b','linewidth',1.2);
plot(tn,ysol(:,2),'r','linewidth',1.2);
plot(tn,ysol(:,3),'k','linewidth',1.2);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Nombre de points -1 de la subdivision en temps
N = size(tn,2)-1;
%pas de la methode
h = tn(2)-tn(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode Euler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yn=y0;
%matrice qui va contenir les valeurs de la solution
%la colonne 1 de yEuler contient les valeurs de la suite a_n qui approche a(t_n)
%la colonne 2 de yEuler contient les valeurs de la suite a_n qui approche b(t_n)
%la colonne 3 de yEuler contient les valeurs de la suite a_n qui approche c(t_n)
yEuler(1,:)=yn;
for i=1:N
yn = (eye(3,3)+h*M)*yn;
yEuler(i+1,:)=yn;
end

%on affiche les solutions
figure(1)
hold on
plot(tn,yEuler(:,1),'b:','linewidth',1.5);
plot(tn,yEuler(:,2),'r:','linewidth',1.5);
plot(tn,yEuler(:,3),'k:','linewidth',1.5);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode Runge Kutta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yn=y0;
yRK2(1,:)=yn;
for i=1:N
yn = (eye(3,3)+h*M+1/2*h^2*(M*M))*yn;
yRK2(i+1,:)=yn;
end

%on affiche les solutions
figure(1)
hold on
plot(tn,yRK2(:,1),'b-.','linewidth',1.5);
plot(tn,yRK2(:,2),'r-.','linewidth',1.5);
plot(tn,yRK2(:,3),'k-.','linewidth',1.5);
legend('a(t)','b(t)','c(t)','a_n Euler','b_n Euler','c_n Euler','a_n RK2','b_n RK2','c_n RK2');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


