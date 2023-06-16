#!/bin/bash
clear

echo "------Información relevante del procesador------"
echo ""
lscpu | grep "Nombre del modelo:"
lscpu | grep "CPU(s)"
echo ""

echo "------Información relevante de la memoria------"
echo ""
free
echo ""

echo "------Información relevante del disco duro------"
echo ""
df
echo ""
