       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLOYEE-FILE ASSIGN TO "data/employees.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORT-FILE ASSIGN TO "output/payroll_report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD EMPLOYEE-FILE.
       01 EMPLOYEE-RECORD.
           05 ER-ID           PIC X(5).
           05 FILLER          PIC X.
           05 ER-NAME         PIC X(20).
           05 FILLER          PIC X.
           05 ER-HOURS        PIC 9(3).
           05 FILLER          PIC X.
           05 ER-RATE         PIC 9(3)V99.

       FD REPORT-FILE.
       01 REPORT-RECORD       PIC X(120).

       WORKING-STORAGE SECTION.
       01 WS-EOF              PIC X VALUE "N".
           88 END-OF-FILE     VALUE "Y".
           88 NOT-END-OF-FILE VALUE "N".

       01 WS-GROSS-PAY        PIC 9(7)V99 VALUE 0.
       01 WS-TAX              PIC 9(7)V99 VALUE 0.
       01 WS-NET-PAY          PIC 9(7)V99 VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT EMPLOYEE-FILE
                OUTPUT REPORT-FILE

           WRITE REPORT-RECORD FROM
               "PAYROLL REPORT"
           WRITE REPORT-RECORD FROM
               "ID    NAME                 GROSS PAY     TAX           NET PAY"

           PERFORM UNTIL END-OF-FILE
               READ EMPLOYEE-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       PERFORM PROCESS-EMPLOYEE
               END-READ
           END-PERFORM

           CLOSE EMPLOYEE-FILE
                 REPORT-FILE

           DISPLAY "Payroll report generated in output/payroll_report.txt"
           STOP RUN.

       PROCESS-EMPLOYEE.
           COMPUTE WS-GROSS-PAY = ER-HOURS * ER-RATE
           COMPUTE WS-TAX = WS-GROSS-PAY * 0.15
           COMPUTE WS-NET-PAY = WS-GROSS-PAY - WS-TAX

           STRING
               ER-ID DELIMITED BY SIZE
               "   " DELIMITED BY SIZE
               ER-NAME DELIMITED BY SIZE
               "   " DELIMITED BY SIZE
               WS-GROSS-PAY DELIMITED BY SIZE
               "   " DELIMITED BY SIZE
               WS-TAX DELIMITED BY SIZE
               "   " DELIMITED BY SIZE
               WS-NET-PAY DELIMITED BY SIZE
               INTO REPORT-RECORD
           END-STRING

           WRITE REPORT-RECORD.
