classdef tests < matlab.unittest.TestCase
    
    properties
        calcs
        calibs
        Set
        drop
        proc
    end
    
    methods(TestClassSetup)
        function classSetup(testCase)
            addpath('processes');
            testCase.calcs = {@max_load, @max_accx, @max_accy, @max_accz, @max_loadx, @max_loady, @max_loadz};
            testCase.calibs = {@calib_load, @calib_load_triax, @calib_pos};
            testCase.Set = dropSet('test\data\', 0, true);
        end
    end
    
    methods(TestMethodSetup)
        function setup(testCase)
            testCase.drop = testCase.Set.drops(1).Value;
            testCase.proc = processor();
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end
    
    methods(Test)
        
        function testdropSetConstructor(testCase)
            testCase.assertNumElements(testCase.Set.drops, 24);
            testCase.assertEqual(testCase.Set.num_drops, length(testCase.Set.drops));
            testCase.assertEqual(testCase.Set.three_axis_load, true);
        end
        
        function testdropConstructorTriaxLoad(testCase)
            testCase.assertNotEmpty(testCase.drop.time);
            testCase.assertNotEmpty(testCase.drop.pos);
            testCase.assertNotEmpty(testCase.drop.load);
            testCase.assertNotEmpty(testCase.drop.accx);
            testCase.assertNotEmpty(testCase.drop.accy);
            testCase.assertNotEmpty(testCase.drop.accz);
            testCase.assertNotEmpty(testCase.drop.loadx);
            testCase.assertNotEmpty(testCase.drop.loady);
            testCase.assertNotEmpty(testCase.drop.loadz);
        end
        
        function testDropConstructorNoTriaxLoad(testCase)
            noTriaxSet = dropSet('test\data\', 0, false);
            drop = noTriaxSet.drops(1).Value;
            
            testCase.assertNotEmpty(drop.time);
            testCase.assertNotEmpty(drop.pos);
            testCase.assertNotEmpty(drop.load);
            testCase.assertNotEmpty(drop.accx);
            testCase.assertNotEmpty(drop.accy);
            testCase.assertNotEmpty(drop.accz);
            testCase.assertEmpty(drop.loadx);
            testCase.assertEmpty(drop.loady);
            testCase.assertEmpty(drop.loadz);
        end
        
        function testProcessorConstructor(testCase)
            testCase.assertInstanceOf(testCase.proc, 'processor');
        end
        
        function testNextOpenCol(testCase)
            testCase.proc.calculated = {'one', 'two', 'three'};
            testCase.assertEqual(testCase.proc.next_open_col, 4);
            testCase.proc.calculated = {};
        end
            
        function testNextOpenRow(testCase)
            testCase.proc.calculated = {'one'; 'two'; 'three'};
            testCase.assertEqual(testCase.proc.next_open_row, 4);
            testCase.proc.calculated = {};
        end
        
        function testAddField(testCase)
            test_text = '%&(*a thing;';
            test_text2 = 'another 609d6fas6fdsa&)(*, thing';
            
            field_number = testCase.proc.add_field(test_text);
            testCase.assertEqual(field_number, 1);
            testCase.assertEqual(char(testCase.proc.calculated(field_number)), test_text);
            
            field_number = testCase.proc.add_field(test_text2);
            testCase.assertEqual(field_number, 2);
            testCase.assertEqual(char((testCase.proc.calculated(field_number))), test_text2);
            
            testCase.proc.calculated = {};
        end
        
        function testAddValue_for_Num(testCase)
            field_number = testCase.proc.add_field('test');
            value = 7.21234;
            value_index = testCase.proc.add_value(value, field_number);
            testCase.assertEqual(value, testCase.proc.calculated{value_index, field_number});
        end
        
        function testAddValue_for_Matrix(testCase)
            field_number = testCase.proc.add_field('test');
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            value_index = testCase.proc.add_value(value, field_number);
            testCase.assertEqual(value, testCase.proc.calculated{value_index, field_number});
        end
    end
end