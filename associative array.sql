------------------------------------------------------------
---associative array
DECLARE
/*TYPE population IS TABLE OF NUMBER
INDEX BY VARCHAR2(30);*/

TYPE population IS TABLE OF NUMBER
INDEX BY PLS_INTEGER;

TYPE population IS TABLE OF NUMBER
INDEX BY POSITIVE;

v population;
i VARCHAR2(30);
--i NUMBER;
BEGIN
/*    v('delhi'):=2500000;
    v('pune'):=2320000;
    v('mumbai'):=3450000;
    v('banglore'):=7660000;
    v('punjab'):=9720000;
    v('shimla'):=78800000;  */
  v(2):=2500000;
  v(878789):=2320000;
  v(-1222):=3450000;
  v(67789):=7660000;
  v(66):=9720000;
  v(97):=78800000;
  
i:=v.first;
WHILE (i IS NOT NULL)
 LOOP
   dbms_output.put_line('Index value = '||rpad(i,10,' ')||'Element value = '||v(i));
    i:=v.next(i);   
 END LOOP;

dbms_output.put_line('reverse order-----------------');    
i:=v.last;
WHILE (i IS NOT NULL)
 LOOP
   dbms_output.put_line('Index value = '||rpad(i,10,' ')||'Element value = '||v(i));
    i:=v.prior(i);   
 END LOOP; 
    
dbms_output.put_line('---------------------------------');   
dbms_output.put_line('first_index value = '||v.first);
dbms_output.put_line('last_index value = '||v.last);
dbms_output.put_line('total count = '||v.count);
/*j:=1;
FOR j IN v.first..v.last LOOP
    dbms_output.put_line(v(j));
    END LOOP;*/
/*FOR i IN v.first..v.last
  LOOP
    IF v.exists(i) THEN
    dbms_output.put_line(i||'  '||v(i));
    END IF;
  --  i:=v.next(i);
  END LOOP;   */
/*LOOP
  EXIT WHEN j IS NULL;
    dbms_output.put_line(j||'  '||v(j));
    i:=v.next(j);
END LOOP;*/
END;
-----------------------------------------------------------------------
--associative ARRAY WITH RECORDS TYPE
DECLARE 
TYPE emp_det IS TABLE OF emp%ROWTYPE 
INDEX BY PLS_INTEGER;

var_emp emp_det;
BEGIN
  FOR i IN (SELECT * FROM emp)
    LOOP
      var_emp(var_emp.count+1):=i;
    END LOOP;
    dbms_output.put_line(var_emp.count);
    
    FOR i IN 1..var_emp.count 
      LOOP
        dbms_output.put_line(var_emp(i).last_name);
      END LOOP;
END;
----------------------------------------------------------------------
DECLARE 
CURSOR cur IS SELECT * FROM emp;

TYPE emp_idx_int IS TABLE OF emp%ROWTYPE
INDEX BY PLS_INTEGER;

v_emp_idx_int emp_idx_int;

/*we can REFERENCE VARCHAR datatype IN INDEX*/
TYPE emp_idx_name IS TABLE OF emp%ROWTYPE
INDEX BY employees.last_name%TYPE;

/*\*we cannot REFERENCE number datatype IN INDEX*\
TYPE emp_idx_name IS TABLE OF emp%ROWTYPE
INDEX BY employees.employee_id%TYPE;*/

v_emp_idx_name emp_idx_name;
BEGIN
  ------populate without cursor
  FOR i IN (SELECT * FROM emp)
    LOOP
      v_emp_idx_int(v_emp_idx_int.count+1):=i;
    END LOOP;
      dbms_output.put_line(v_emp_idx_int.last);
      dbms_output.put_line(v_emp_idx_int.count);
  ------populate with cursor
  FOR i IN cur 
    LOOP
      v_emp_idx_int(cur%ROWCOUNT):=i;
    END LOOP;
      dbms_output.put_line(v_emp_idx_int.last);
      dbms_output.put_line(v_emp_idx_int.count);
  -----Populated with index value employee_id
    FOR i IN cur 
    LOOP
      v_emp_idx_int(i.employee_id):=i;
    END LOOP;
      dbms_output.put_line(v_emp_idx_int(100).last_name);
      dbms_output.put_line(v_emp_idx_int(138).last_name);    
  -----Populated with index value last_name
    FOR i IN cur 
    LOOP
--      IF v_emp_idx_name.exists(i.last_name) THEN
  --            dbms_output.put_line(' index repeated --'||i.last_name);
    --  ELSE
      v_emp_idx_name(i.last_name):=i;
     -- END IF;
    END LOOP;
      dbms_output.put_line(v_emp_idx_name('King').employee_id);
      dbms_output.put_line(v_emp_idx_name('Stiles').employee_id);
      dbms_output.put_line(v_emp_idx_name.count);
END;
      
