//
//  main.swift
//  Interpolation
//
//  Created by Даниил Волошин on 7/10/18.
//  Copyright © 2018 Даниил Волошин. All rights reserved.
//

import Foundation

//Function that interpolates
func interpol(a: Float, b: Float, c: Float, za: Float, zb: Float) -> Float {
    return za+(c-a)/(b-a)*(zb-za)
}


//Function that eliminates X
func elimX(array1: [[Float]], array2: inout [[Float]], x: Float) {
    if x<0 {
        for i in 0 ... 869 {
            for j in 0 ... 4 {
                array2[i][j]=interpol(a: -4, b: 0, c: x, za: 0, zb: array1[i][j])
            }
        }
    }
    if x>0 {
        for i in 0 ... 869 {
            for j in 0 ... 4 {
                array2[i][j]=interpol(a: 0, b: 4, c: x, za: array1[i][j], zb: 0)
            }
        }
    }
    if x==0 {
        for i in 0 ... 869 {
            for j in 0 ... 4 {
                array2[i][j]=array1[i][j]
            }
        }
    }
}


//Function that eliminates Y
func elimY(array1: [[Float]], array2: inout [[Float]], g: [Float], y: Float) {
    var a, b, za, zb: Float; a=0; b=0; za=0; zb=0;
    var q=0
    var isPresent = false
    for i in 0 ... 28 {
        if y==g[i] {
            isPresent=true
            q=i
        }
    }
    if isPresent==false {
        for i in 1 ... 28 {
            if y>g[i-1] && y<g[i] {
                a=g[i-1]
                b=g[i]
                q=i
            }
        }
    }
    
    if isPresent==true {
        var k=0
        for i in 30*(q+1)-29-1 ... 30*(q+1)-1 {
            for j in 0 ... 4 {
                array2[k][j]=array1[i][j]
            }
            k=k+1
        }
    }
    
    if isPresent==false {
        var k=0
        for i in 30*q-29-1 ... 30*q-1 {
            for j in 0 ... 4 {
                za=array1[i][j]
                zb=array1[i+30][j]
                array2[k][j]=interpol(a: a, b: b, c: y, za: za, zb: zb)
            }
            k=k+1
        }
    }
}


//Function that eliminates Mach
func elimMach(array1: [[Float]], array2: inout [[Float]], g: [Float], mach: Float) {
    var a, b, za, zb: Float; a=0; b=0; za=0; zb=0;
    var q=0
    var isPresent = false
    for i in 0 ... 5 {
        if mach==g[i] {
            isPresent=true
            q=i
        }
    }
    if isPresent==false {
        for i in 1 ... 5 {
            if mach>g[i-1] && mach<g[i] {
                a=g[i-1]
                b=g[i]
                q=i
            }
        }
    }
    
    if isPresent==true {
        var k=0
        for i in 5*(q+1)-4-1 ... 5*(q+1)-1 {
            for j in 0 ... 4 {
                array2[k][j]=array1[i][j]
            }
            k=k+1
        }
    }
    
    if isPresent==false {
        var k=0
        for i in 5*q-4-1 ... 5*q-1 {
            for j in 0 ... 4 {
                za=array1[i][j]
                zb=array1[i+5][j]
                array2[k][j]=interpol(a: a, b: b, c: mach, za: za, zb: zb)
            }
            k=k+1
        }
    }
}


//Function that eliminates Beta
func elimBeta(array1: [[Float]], array2: inout [Float], g: [Float], beta: Float) {
    var a, b, za, zb: Float; a=0; b=0; za=0; zb=0;
    var q=0
    var isPresent = false
    for i in 0 ... 4 {
        if beta==g[i] {
            isPresent=true
            q=i
        }
    }
    if isPresent==false {
        for i in 1 ... 4 {
            if beta>g[i-1] && beta<g[i] {
                a=g[i-1]
                b=g[i]
                q=i
            }
        }
    }
    
    if isPresent==true {
        for j in 0 ... 4 {
            array2[j]=array1[q][j]
        }
    }
    
    if isPresent==false {
        for j in 0 ... 4 {
            za=array1[q-1][j]
            zb=array1[q][j]
            array2[j]=interpol(a: a, b: b, c: beta, za: za, zb: zb)
        }
    }
}


//Function that eliminates Alpha
func elimAlpha(array1: [Float], answer: inout Float, g: [Float], alpha: Float) {
    var a, b, za, zb: Float; a=0; b=0; za=0; zb=0;
    var q=0
    var isPresent = false
    for i in 0 ... 4 {
        if alpha==g[i] {
            isPresent=true
            q=i
        }
    }
    if isPresent==false {
        for i in 1 ... 4 {
            if alpha>g[i-1] && alpha<g[i] {
                a=g[i-1]
                b=g[i]
                q=i
            }
        }
    }
    
    if isPresent==true {
        answer=array1[q]
    }
    
    if isPresent==false {
        za=array1[q-1]
        zb=array1[q]
        answer=interpol(a: a, b: b, c: alpha, za: za, zb: zb)
    }
}





//Fill the "data" array
fillTheArray()

//Declare and fill additional arrays of varibales
let alpha: [Float] = [-4,0,4,8,12]
let beta: [Float] = [-4,-2,0,2,4]
let mach: [Float] = [0.2,0.8,1.3,1.7,2,2.3]
let y: [Float] = [0.0000,0.0910,0.2180,0.3340,0.4560,0.5720,0.6990,0.8210,0.9350,1.0530,1.1780,1.2950,1.4160,1.5420,1.6560,1.7710,1.9010,2.0120,2.1320,2.2560,2.3730,2.4920,3.0000,4.0000,5.0000,6.0000,7.0000,9.0000,11.0000]

var arrayY = [[Float]](repeating: [Float](repeating: 0, count: 5), count: 870)
var arrayMach = [[Float]](repeating: [Float](repeating: 0, count: 5), count: 30)
var arrayBeta = [[Float]](repeating: [Float](repeating: 0, count: 5), count: 5)
var arrayAlpha = [Float](repeating: 0, count: 5)
var answer: Float; answer = 3.14


elimX(array1: data,array2: &arrayY, x: 0);
elimY(array1: arrayY, array2: &arrayMach, g: y, y: 0.091);
elimMach(array1: arrayMach, array2: &arrayBeta, g: mach, mach: 2);
elimBeta(array1: arrayBeta, array2: &arrayAlpha, g: beta, beta: -3);
elimAlpha(array1: arrayAlpha, answer: &answer, g: alpha, alpha: -2);



print("mz = \(answer)")







