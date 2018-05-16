data=elCentroData(2,:);
l=size(data,2);
n=3;
Y=(data(1,1+n:end))';
phi=zeros(l-n,n);
for i=1:1:l-n
    phi(i, :)=data(1,i:i+n-1);
end

cond(phi)

theta=pinv(phi)*Y;

Y'*Y-Y'*phi*pinv(phi)*Y

for i=1:1:10
    phi=[phi,phi(:,end-n+1:end)*theta];
end

plot(1:1:l-n,Y,1+i:1:l-n+i,phi(:,end-n+1:end)*theta)

G=[zeros(n-1,1), eye(n-1);theta'];