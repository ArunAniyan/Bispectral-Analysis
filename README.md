# Bispectral-Analysis

Matlab Code for Bispectral Analysis of Signals

Authors : Arun Aniyan, Deepthi R.

Institute : Department of Physics, St.Thomas College, Kozhencherry, Kerala, India.

Email : aka.bhagya@gmail.com, deepthi78@gmail.com

02-05-2013


File list : 
1. bsptra4.m  --> Main code

2. mkbsp.m    --> Plot code 

3. sampledata1.txt --> Sample data 1

4. sampledata2.txt --> Sample data 2


How to test code
================

The main code bsptra4.m takes in 3 input arguments and gives 3 output arguments.
The input arguments are filename of the data file, channel number and plot range. The output values are bispectral frequencies f1 and f2, nomalised amplitude of bispectral peaks.

To test type the following in the matlab command prompt.
Example(1):

     [f1 f2 b] = bsptra4('sampledata1.txt',12,128);

Example(2):

     [f1 f2 b] = bsptra4('sampledata2.txt',23,40);		


Note
====

The current code is written for the data with a sampling rate of 256Hz. The bispectral plot will have the range from 1 to 128Hz. But there will not always be bispectral peaks in the complete range of frequencies. If there are only bispectral peaks below a certian value say 40, the third arguemnt can be changed to that range so it will show a zoomed plot of the bispectrum till that range.

The plot is shown as viewed from the top. The view angle can be changed from the rotate option in the matlab figure window.
