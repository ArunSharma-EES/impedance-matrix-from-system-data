clear;
clc;

%% reading the System Data file
filename = 'System Data.xlsx';
System_data = readtable(filename);
Bus = rmmissing(System_data.BUS);
B_sh = rmmissing(System_data.Bus_Susceptance);
From = rmmissing(System_data.From_bus);
To = rmmissing(System_data.To_Bus);
R = rmmissing(System_data.R);
X = rmmissing(System_data.X);
B = rmmissing(System_data.B);


%% Initial data required
n = length(Bus);
m = length(From);
flag = zeros(n,n);
impedance_matrix = nan.*ones(n,n);
Z_line = R + X*1i;
Z = zeros(n+1,n+1);


%% Impedance Matrix Formation
for i = 1:m
    a = From(i);
    b = To(i);
    impedance_matrix(a,b) = Z_line(i,1);
    impedance_matrix(b,a) = Z_line(i,1);
    flag(a,b) = 1;
    flag(b,a) = 1;
    B_sh(a) = B_sh(a) + B(i)/2;
    B_sh(b) = B_sh(b) + B(i)/2;
end

for i = 1:n
    if B_sh(i) ~= 0
        impedance_matrix(i,i) = 1/(B_sh(i)*1i);
        flag(i,i) = 1;
    end
end


%% Z bus formation step 1
for i = 1:n
    if ~isnan(impedance_matrix(i,i))
        Z(i,i) = impedance_matrix(i,i);
        flag(i,i) = 0;
    end
end

%% Z bus formation step 2
for i = 1:n
    for j = 1:n
        if (Z(j,:) == 0 & Z(:,j) == 0) & ~isnan(impedance_matrix(i,j))
            Z(j,:) = Z(i,:);
            Z(:,j) = Z(j,:).';
            Z(j,j) = Z(i,j) + impedance_matrix(i,j);
            flag(i,j) = 0;
            flag(j,i) = 0;
        end
    end
end

%% Z bus formation step 3
k = n+1;
for i = 1:n
    for j = 1:n
        if flag(i,j) == 1
            Z(k,1:n) = Z(i,1:n) - Z(j,1:n);
            Z(1:n,k) = Z(k,1:n).';
            Z(k,k) = impedance_matrix(i,j) + Z(i,i) + Z(j,j) - 2*Z(i,j); 
            Z(1:n,1:n) = Z(1:n,1:n) - (Z(1:n,k)*Z(k,1:n)/Z(k,k));
            flag(i,j) = 0;
            flag(j,i) = 0;
        end
    end
end
Z = Z(1:n,1:n);






%% Writing Z bus in output file
filename = 'Arun Sharma 2022EES2078.xlsx';
delete(filename);
Z = num2cell(Z);
Z = cellfun(@num2str , Z, 'UniformOutput', false);
% result{1,1}="Arun Sharma (2022EES078)";
% result{2,1}=Z;
result = table(Z);
result = mergevars(result,{},'NewVariableName',"Arun Sharma (2022EES078)",'MergeAsTable',true);
writetable(result,filename);