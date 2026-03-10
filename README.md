# COBOL Payroll Portfolio Project

This project is a simple payroll processing system written in COBOL.

It reads employee data from a text file, calculates gross pay, tax, and net pay, then generates a payroll report.

## Compile

Using GnuCOBOL:

cobc -x -free src/payroll.cbl -o payroll

## Run

./payroll

## Structure

src/payroll.cbl
data/employees.txt
output/payroll_report.txt
