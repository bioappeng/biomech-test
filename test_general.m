classdef test_general < matlab.unittest.TestCase
    properties
        asciiSet 
        matSet
        ascii_drop_early
        ascii_drop_middle
        mat_drop_early
        mat_drop_middle
        collector
    end
    
    methods(TestClassSetup)
        function class_setup_ascci(testCase)
            testCase.asciiSet = dropSet('test/other/', 0, true, true);
        end

        function class_setup_mat(testCase)
            testCase.matSet = dropSet('test/sweden/test.mat', 0, true, false);
        end
    end
    
    methods(TestMethodSetup)
        function setup_general(testCase)
            testCase.collector = parameter_collector();
        end

        function setup_ascii(testCase)
            testCase.ascii_drop_early = testCase.asciiSet.drops(1).Value;
            testCase.ascii_drop_middle = testCase.asciiSet.drops(5).Value;
        end

        function setup_mat(testCase)
            testCase.mat_drop_early = testCase.matSet.drops(1).Value;
            testCase.mat_drop_middle = testCase.matSet.drops(5).Value;
            testCase.collector = parameter_collector();
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end
    
    methods(Test)
        function test_dropSet_constructor_ascii(testCase)
            testCase.assertInstanceOf(testCase.asciiSet, 'dropSet');
            testCase.assertNotEmpty(testCase.asciiSet.drops);
            testCase.assertEqual(testCase.asciiSet.num_drops, length(testCase.asciiSet.drops));
            testCase.assertEqual(testCase.asciiSet.three_axis_load, true);
        end

        function test_dropSet_constructor_mat(testCase)
            testCase.assertInstanceOf(testCase.matSet, 'dropSet');
            testCase.assertNotEmpty(testCase.matSet.drops);
            testCase.assertEqual(testCase.matSet.num_drops, length(testCase.matSet.drops));
            testCase.assertEqual(testCase.matSet.three_axis_load, true);
        end

        function test_drop_constructor_ascii(testCase)
            testCase.assertInstanceOf(testCase.ascii_drop_early, 'asciiDrop');
            testCase.assertInstanceOf(testCase.ascii_drop_middle, 'asciiDrop');
            testCase.assertNotEmpty(testCase.ascii_drop_early.pot);
            testCase.assertNotEmpty(testCase.ascii_drop_early.accy);
            testCase.assertNotEmpty(testCase.ascii_drop_middle.pot);
            testCase.assertNotEmpty(testCase.ascii_drop_middle.accy);
        end

        function test_drop_constructor_mat(testCase)
            testCase.assertInstanceOf(testCase.mat_drop_early, 'matDrop');
            testCase.assertInstanceOf(testCase.mat_drop_middle, 'matDrop');
            testCase.assertNotEmpty(testCase.mat_drop_early.pot);
            testCase.assertNotEmpty(testCase.mat_drop_early.accy);
            testCase.assertNotEmpty(testCase.mat_drop_middle.pot);
            testCase.assertNotEmpty(testCase.mat_drop_middle.accy);
        end

        function testAddValue_for_Num(testCase)
            field_name = 'test';
            value = 7.21234;
            testCase.collector.add_data(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('test'));
        end
        
        function testAddValue_for_Matrix(testCase)
            field_name = 'test';
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            testCase.collector.add_data(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('test'));
        end
    end
end
