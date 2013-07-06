classdef tests < matlab.unittest.TestCase
    
    properties
        calcs
        calibs
        Set
        drop
        proc
        collector
    end
    
    methods(TestClassSetup)
        function classSetup(testCase)
            addpath('processes');
            testCase.calcs = {@max_load, @max_accx, @max_accy, @max_accz, @max_loadx, @max_loady, @max_loadz};
            testCase.calibs = {@calib_load, @calib_load_triax, @calib_pos};
            testCase.Set = dropSet('test/', 0, true);
        end
    end
    
    methods(TestMethodSetup)
        function setup(testCase)
            testCase.drop = testCase.Set.drops(1).Value;
            testCase.collector = parameter_collector();
            testCase.proc = processor();
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end
    
    methods(Test)
        
        function testdropSetConstructor(testCase)
            testCase.assertEqual(testCase.Set.num_drops, length(testCase.Set.drops));
            testCase.assertEqual(testCase.Set.three_axis_load, true);
        end
        
        function testNextOpenCol(testCase)
            testCase.collector.calculated = {'one', 'two', 'three'};
            testCase.assertEqual(testCase.collector.next_open_col, 4);
            testCase.collector.calculated = {};
        end
            
        function testNextOpenRow(testCase)
            testCase.collector.calculated = {'one'; 'two'; 'three'};
            testCase.assertEqual(testCase.collector.next_open_row, 4);
            testCase.collector.calculated = {};
        end
        
        function testAddField(testCase)
            test_text = '%&(*a thing;';
            test_text2 = 'another 609d6fas6fdsa&)(*, thing';
            
            field_number = testCase.collector.add_field(test_text);
            testCase.assertEqual(field_number, 1);
            testCase.assertEqual(char(testCase.collector.calculated(field_number)), test_text);
            
            field_number = testCase.collector.add_field(test_text2);
            testCase.assertEqual(field_number, 2);
            testCase.assertEqual(char((testCase.collector.calculated(field_number))), test_text2);
            
            testCase.collector.calculated = {};
        end
        
        function testAddValue_for_Num(testCase)
            field_number = testCase.collector.add_field('test');
            value = 7.21234;
            value_index = testCase.collector.add_value(value, field_number);
            testCase.assertEqual(value, testCase.collector.calculated{value_index, field_number});
        end
        
        function testAddValue_for_Matrix(testCase)
            field_number = testCase.collector.add_field('test');
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            value_index = testCase.collector.add_value(value, field_number);
            testCase.assertEqual(value, testCase.collector.calculated{value_index, field_number});
        end

        function testApplyProcess(testCase)
            function field_number = basicProcess(collector, dropSet)
                value = 12341;
                field_number = collector.add_field('basic');
                value_index = collector.add_value(value, field_number);
            end
            field_number = testCase.proc.apply_process(testCase.collector, testCase.Set, @basicProcess);
            testCase.assertEqual(value,testCase.collector.calculated{2:end,field_number});
        end
    end
end
