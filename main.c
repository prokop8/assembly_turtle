#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MAX 1024
#define komenda_ustaw 1
#define komenda_podnies 2
#define komenda_opusc 3
#define komenda_naprzod 4
#define komenda_obrot 5

typedef struct DrawingContextStruct
{
    unsigned char *bufor;
    int kat;
    int x1;
    int y1;
    int color;
    double sinus;
    double cosinus;
}DrawingContextStruct;
DrawingContextStruct dc;

double pi_180=0.017453288;
int turtle( int komenda, int param1, int param2, DrawingContextStruct *dc);
void WriteLine(int x1,int y1,int x2,int y2,int color, unsigned char *buf);
void coloring(int x,int y,int color, unsigned char *buf);
void readline(char *c);

int main(int argc, char* argv[])
{
    dc.kat=0;
    dc.x1=0;
    dc.y1=0;
    dc.sinus=sin(0);
    dc.cosinus=cos(0);
    char str1[]="/home/users/pprakapc/Pulpit/turtle/";
    strcat(str1,argv[2]);
    FILE *plik1 = fopen(argv[2], "wb+");
    //FILE *plik1 = fopen("/home/users/pprakapc/Pulpit/turtle/plik.bmp", "wb+");
    char header[54]={'B','M',
                    0x36,0xE1,0x00,0x00,
                    0x00,0x00,0x00,0x00,
                    0x28,0x00,0x00,0x00,
                    0x28,0x00,0x00,0x00,
                    0xA0,0x00,0x00,0x00,
                    0x78,0x00,0x00,0x00,
                    0x01,0x00,
                    0x18,0x00,
                    0x00,0x00,0x00,0x00,
                    0x00,0x00,0x00,0x00,
                    0x00,0x00,0x00,0x00,
                    0x00,0x00,0x00,0x00,
                    0x00,0x00,0x00,0x00,
                    0x00,0x00,0x00,0x00};
    int i=0;
    for(i=0;i<54;i++)
        fprintf(plik1,"%c",header[i]);
    i=0;
    char str[57600];
    for(i=0;i<57600;i++)
        str[i]=255;
    dc.bufor=str;
    char s[MAX];
    char c[MAX];
    int j=0;
    FILE *plik = fopen(argv[1], "a+");
    while (fscanf(plik, "%s", s) != EOF)
    {
        int i=0;
        while(s[i]!='\0')
        {
            c[j]=s[i];
            if(s[i]==';')
            {
                readline(c);
                int k;
                for(k=0;k<=MAX;k++)
                    c[k]=0;
                j=-1;
            }
            i++;
            j++;
        }
        if(j!=0)
        {
            c[j]=' ';
            j++;
        }
    }
    for(i=0;i<57600;i++)
        fprintf(plik1,"%c",str[i]);
    fclose(plik1);
    fclose(plik);
    return 0;
}

void readline(char *c)
{
    int l=0;
    int arg1=0;
    int arg2=0;
    int arg3=0;
    int ret=0;
    switch(c[0])
    {
        case 'u':
            while(c[7+l]!=',')
            {
                arg1=arg1*10;
                arg1+=c[7+l];
                arg1-=48;
                l++;
            }
            l++;
            while(c[7+l]!=']')
            {
                arg2=arg2*10;
                arg2+=c[7+l];
                arg2-=48;
                l++;
            }
            l+=3;
            while(c[7+l]!=';')
            {
                arg3=arg3*10;
                arg3+=c[7+l];
                arg3-=48;
                l++;
            }
            dc.kat=arg3;
            dc.sinus=sin(arg3*pi_180);
            dc.cosinus=cos(arg3*pi_180);
            ret=turtle(komenda_ustaw, arg1, arg2, &dc);
            break;
        case 'p':
            ret=turtle(komenda_podnies, arg1, arg2, &dc);
            break;
        case 'n':
            while(c[8+l]!=';')
            {
                arg1=arg1*10;
                arg1+=c[8+l];
                arg1-=48;
                l++;
            }
            ret=turtle(komenda_naprzod, arg1, arg2, &dc);
            break;
        case 'o':
            if(c[1]=='b')
            {
                while(c[6+l]!=';')
                {
                    arg1=arg1*10;
                    arg1+=c[6+l];
                    arg1-=48;
                    l++;
                }
                dc.sinus=sin(arg1*pi_180);
                dc.cosinus=cos(arg1*pi_180);
                ret=turtle(komenda_obrot, arg1, arg2, &dc);
            }
            else
            {
                ret=turtle(komenda_opusc, arg1, arg2, &dc);
            }
            break;
        default:break;
    }
    if(ret!=0)
        return;
    l=0;
    arg1=0;
    arg2=0;
    arg3=0;
    ret=0;
}
