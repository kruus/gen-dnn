
/** greatest common denominator, a,b > 0 */
static int gcd(int a, int b)
{
    for (;;)
    {
        if (a == 0) return b;
        b %= a;
        if (b == 0) return a;
        a %= b;
    }
}

/** lowest common multiple, a,b > 0 */
static int lcm(int a, int b)
{
    int temp = gcd(a, b);

    return temp ? (a / temp * b) : 0;
}

#include <iostream>
using namespace std;
/** Solve for integers j, k and g=gcd(a,b) such that \f$ka + by = g\f$,
 * where a,b are integer constants.
 * This is a linear equation in integers, and is solved
 * via the extended Euclid algorithm.
 */
static void inline extendedEuclid( int& k, int a, int& j, int b, int& g)
{
  //int a0=a, b0=b;
  int x = 1, y = 0;
  int xLast = 0, yLast = 1;
  int q, r, m, n;
  while (a != 0) 
  {
    q = b / a;
    r = b % a;
    m = xLast - q * x;
    n = yLast - q * y;
    xLast = x;
    yLast = y;
    x = m; 
    y = n;
    b = a; 
    a = r;
    //cout<<" ee... "<<xLast<<"*"<<a0<<" + "<<yLast<<"*"<<b0<<" = "<<xLast*a0+yLast*b0
    //  <<"  a="<<a<<" b="<<b<<" x="<<x<<" y="<<y<<endl;
  }
  // During above, xlast alternates +ve, -ve, ...
  // Let's always provide the solution such that k >= 0 ...
  if (xLast < 0){
    //xLast += b0/b; yLast -= a0/b;
    // lowest common multiples (b/gcd and a/gcd) are in x,y
    xLast += x;
    yLast += y;
  }
  g = b;
  k = xLast;
  j = yLast;
}
int main(int, char**){
  int a, b;
  cout<<"Input a,b integers: "; cout.flush();
  cin>> a >> b;
  int k, j, g;
  extendedEuclid(k, a, j, b, g);
  int v = k + b/g;
  int w = j - a/g;
  cout<<"     gcd("<<a<<","<<b<<")="<<g
    <<"    "<<k<<"*"<<a<<" + "<<j<<"*"<<b<<" = "<<k*a+j*b
    <<"    "<<v<<"*"<<a<<" + "<<w<<"*"<<b<<" = "<<v*a+w*b<<endl;
	cout<<" Goodbye!"<<endl;
}
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s
