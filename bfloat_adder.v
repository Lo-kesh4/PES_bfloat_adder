
module bfloat_adder(a,b,c);
input  [15:0]a,b;
output reg [15:0]c;

reg [15:0]a1,b1,temp;
reg [7:0]ea,eb,e,bias; //bias dimension
reg [6:0]ma,mb,m_f;
reg [11:0] ma_temp,mb_temp,m_add,m_temp;
reg [8:0]m1;
reg g,r,s0,s1,s,p,s3;

always@(*)
begin
   a1=a;
   b1=b;
   
    if(a1[14:7]<b1[14:7])
      begin
        temp=a1;
        a1=b1;
        b1=temp;
      end
      
ea=a1[14:7];
eb=b1[14:7];

ma=a1[6:0];
mb=b1[6:0];
    
bias=ea-eb;
s3=a[15];

ma_temp[11]=0;
mb_temp[11]=0;
ma_temp[10]=1;
mb_temp[10]=1;
ma_temp[9:3]=ma;
mb_temp[9:3]=mb;
ma_temp[2:0]=0;
mb_temp[2:0]=0;

mb_temp=mb_temp>>bias;

m_add=ma_temp+mb_temp;

e=m_add[11]?(ea+1):ea;
m_temp[9:0]=m_add[11]?m_add[10:1]:m_add[9:0];
m_temp[10]=1;
m_temp[11]=0;

//rounding off
g=m_temp[3];
r=m_temp[2];
s0=m_temp[0];
s1=m_temp[1];
s=s0|s1;
    
p=r&(((~g)&s)|g);

if(p)
    m1=m_temp[11:3]+1;
else
    m1=m_temp[11:3];



m_f=m1[8]?(m1[7:1]):m1[6:0];
e=m1[8]?(e+1):e;

c[15]=s3;
c[6:0]=m_f;
c[14:7]=e;

end

     




endmodule
