%% Bispectral Calculations
% Deepthi R, Arun Kumar A
% deepthi_r78@yahoo.com , aka.bhagya@gmail.com
% Santhom Computing Facility
% 22-03-12
% 17-09-12  - Edited for feature extraction - Aka
% 1-11-12 - Edited for return Bispectrum values - Aka
% 22-1-13 - Edited for feature extraction of Bicoherence

function [g,h,nBs] = bsptra4(flnm,chn,rng)

%Rf1,Rf2,bc1,bc2,

%% Load Data

data_vect = load(flnm);

%% Select channel and zero mean normalization

data_temp = data_vect(chn,:); % Channel Selection

data = data_temp-mean(data_temp); % Zero Mean

l = length(data);

%% FFT and Power

y = fft(data); %% FFT

p = y.*conj(y);     %% Power 

Y = y(1:l/2); %% Required values of FFT
P = real(p(1:l/2)); %% Required values of Power


%% Bispectrum

for m = 1:l/2
    
    for n = 1:l/2
        
        pf = Y(m)*Y(n);
        sf = conj (Y(m)+Y(n));
        B(m,n) = abs(sum(pf*sf));
        
    end
    
end

%% Real Triple Product

for m=1:l/2
    
    for n = 1:l/2
        
        pp = P(m)*P(n);
        sp = P(m)+P(n);
        
        RTP(m,n) = abs(sum(pp*sp));
        

    end
    
end

%% Bicoherence

for m = 1:l/2
    
    for n = 1:l/2
        
        BIC(m,n) = real(100* (B(m,n)/(sqrt(RTP(m,n)))));
        
    end
    
end


%% Triangular Symmetry Calculations

% New Variable Assignments

TB = B;  % Bispectrum
TRTP = RTP; % Real Triple Product
TBIC = BIC; % Bicoherence

i=2;

% Bispectrum
for n=1:l/4
   
   TB(i,1:n) = 0;
   TB(i-1,1:n) = 0;
   
   i=i+2;   
   
end

 k=2;

for m=l/2:-1:(l/4)+1
    
    
    TB(k,m:end) = 0;
    TB(k-1,m:end) =0;
    k=k+2;
    
end



% RTP

i=2;

for n=1:l/4
   
   TRTP(i,1:n) = 0;
   TRTP(i-1,1:n) = 0;
   
   i=i+2;   
   
end

 k=2;
 
for m=l/2:-1:(l/4)+1
    
    
    TRTP(k,m:end) = 0;
    TRTP(k-1,m:end) =0;
    k=k+2;
    
end

% Bicoherence

i=2;

for n=1:l/4
   
   TBIC(i,1:n) = 0;
   TBIC(i-1,1:n) = 0;
   
   i=i+2;   
   
end

 k=2;
 
for m=l/2:-1:(l/4)+1
    
    
    TBIC(k,m:end) = 0;
    TBIC(k-1,m:end) =0;
    k=k+2;
    
end
        
%% Remove Self coupling

% Bispectrum
n=0;
f1=zeros(1,128);
f2=zeros(1,128);
while (n<128)
[a,b]=max(max(TB));
[x,y]=max(TB(:,b));
TB(y,b)=0;
if (b~=y)
    n=n+1;
    f1(n)=y;
    f2(n)=b;  
end
end

    
% Real Triple Product
m=0;
Rf1=zeros(1,10);
Rf2=zeros(1,10);
while (m<10) 
[c,d]=max(max(TRTP));
[p,q]=max(TRTP(:,d));
TRTP(q,d)=0;
if (d~=q)
    m=m+1;
    Rf1(m)=d;
    Rf2(m)=q;
end
 
end

% Bicoherence
k=0;
Bf1=zeros(1,10);
Bf2=zeros(1,10);
while (k<10)
[e,f]=max(max(TBIC));
[m,n]=max(TBIC(:,f));
TBIC(n,f)=0;
if (f~=n)
    k=k+1;
    Bf1(k)=f;
    Bf2(k)=n;
    %e(k)=x
end

end


%% Feature extraction

% Bispectral Frequencies
i=1;
r=i+1;
n=1;

g=zeros(1,128);
h=zeros(1,128);

while (r<=128)            %%% New addition to get exact values
   if ((f1(i)==f2(r)) && (f2(i)==f1(r)))
        g(n)=f1(r);
        h(n)=f2(r);
         n=n+1;
         i=i+2;
         r=i+1;
   else
       i=i+1;
       r=i+1;
   end 
 
end


g(g==0)=[];
h(h==0)=[];

if(isempty(g))
    
    g ='NaN';
    h ='NaN';
    
end

% Bicoherence values 
i=1;
r=i+1;
n=1;

bc1=zeros(1,128);
bc2=zeros(1,128);

while (r<=128)            %%% New addition to get exact values
   if ((f1(i)==f2(r)) && (f2(i)==f1(r)))
        bc1(n)=Bf1(r);
        bc2(n)=Bf2(r);
         n=n+1;
         i=i+2;
         r=i+1;
	if(r>numel(Bf1))
	    break;
	end
   else
       i=i+1;
       r=i+1;
       if(r>numel(Bf1))
	    break;
	   end 
   end 
 
end


bc1(bc1==0)=[];
bc2(bc2==0)=[];

if(isempty(bc1))
    
    bc1 ='NaN';
    bc2 ='NaN';
    
end


%% Bispectrum Normalize and return values


for i=1:length(g)
    
    nB(i) = B(g(i),h(i));   % Values of corrosponding Bispectrum with phase coupling
    
end

nBs = nB./sum(nB);   % Normalised Bispectrum

mkbsp(g,h,nBs,rng);
