function mkbsp(f1,f2,b,rng)
l=256; 
%rng=128; % Plot Range
i=2;
matr = zeros(128,128);

% Triangular Symmetry
for n=1:l/4
   
  matr(i,1:n) = NaN;
  matr(i-1,1:n) = NaN;
   
   i=i+2;   
   
end

 k=2;

for m=l/2:-1:(l/4)+1
    
    
    matr(k,m:end) = NaN;
    matr(k-1,m:end) =NaN;
    k=k+2;
    
end

%% Assign Values
n=length(f1);

for j=1:n
    
    matr(f1(j),f2(j)) = b(j);
end


%% Plot

figure1 = figure;
axes1 = axes('Parent',figure1);
view(axes1,[0 90]);
grid(axes1,'on');
hold(axes1,'all');

surf(matr(1:rng,1:rng),'Parent',axes1), xlabel('f1'), ylabel('f2'), title('Bispectrum') 

