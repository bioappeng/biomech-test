classdef test_general < matlab.unittest.TestCase
    properties
        asciiSet 
        matSet
        ascii_drop_early
        ascii_drop_middle
        mat_drop_early
        mat_drop_middle
    end
    
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../lib/');
        end

        function class_setup_ascii(testCase)
            testCase.asciiSet = dropSet('../test/data/other/', 0, true, true);
        end

        function class_setup_mat(testCase)
            testCase.matSet = dropSet('../test/data/sweden/test.mat', 0, true, false);
        end
    end
    
    methods(TestMethodSetup)
        function setup_general(testCase)
        end

        function setup_ascii(testCase)
            testCase.ascii_drop_early = testCase.asciiSet.drops(1).Value;
            testCase.ascii_drop_middle = testCase.asciiSet.drops(5).Value;
        end

        function setup_mat(testCase)
            testCase.mat_drop_early = testCase.matSet.drops(1).Value;
            testCase.mat_drop_middle = testCase.matSet.drops(5).Value;
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
            testCase.assertEqual(testCase.ascii_drop_early.id, 'TT5_14_091555');
            testCase.assertInstanceOf(testCase.ascii_drop_early, 'asciiDrop');
            testCase.assertInstanceOf(testCase.ascii_drop_middle, 'asciiDrop');
            testCase.assertNotEmpty(testCase.ascii_drop_early.pot.data);
            testCase.assertNotEmpty(testCase.ascii_drop_early.accy.data);
            testCase.assertNotEmpty(testCase.ascii_drop_middle.pot.data);
            testCase.assertNotEmpty(testCase.ascii_drop_middle.accy.data);
        end

        function test_drop_constructor_mat(testCase)
            testCase.assertInstanceOf(testCase.mat_drop_early, 'matDrop');
            testCase.assertInstanceOf(testCase.mat_drop_middle, 'matDrop');
            testCase.assertNotEmpty(testCase.mat_drop_early.pot.data);
            testCase.assertNotEmpty(testCase.mat_drop_early.accy.data);
            testCase.assertNotEmpty(testCase.mat_drop_middle.pot.data);
            testCase.assertNotEmpty(testCase.mat_drop_middle.accy.data);
        end
    end
end
