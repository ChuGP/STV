from selenium import webdriver
from  selenium.webdriver.common.by  import  By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import unittest  # 需要引入 unittest、time、 等程式
from selenium.webdriver.common.keys import Keys
import random
import time
from .Keyword import *

class test_category(unittest.TestCase):  # 測試項目
    def setUp(self):
        self.url="http://127.0.0.1:3000/"  # 要執行自動測試的網站

    def test_create_category(self):
        test=webdriver.Chrome()
        test.get( self.url )
        test.maximize_window()
        login( test )
        sub_tab_go_to_page( test, 'categories' )
        # precondition 
        create_post( test, 'Test' )
        top_tab_go_to_page( test, 'categories' )
        create_post( test, '12345' )
        top_tab_go_to_page( test, 'categories' )
        create_post( test, '!@#$%' )
        top_tab_go_to_page( test, 'categories' )

        exist = is_text_present( test, 'Test' )
        self.assertTrue( exist )
        exist = is_text_present( test, '12345' )
        self.assertTrue( exist )
        exist = is_text_present( test, '!@#$%' )
        self.assertTrue( exist )
        
        time.sleep(2)
        test.close()
    
    def test_show_post(self):
        test=webdriver.Chrome()
        test.get( self.url )
        test.maximize_window()
        # precondition
        login( test )
        get_web_element( test, '//a[contains(@href,"posts") and contains(@class,"dashboard-group__list-tile")]' ).click() 
        # go to create page
        create_post( test, 'I AM GP' )
        stateText = select_dropdown_field( test , 'state',  'Published' )
        self.assertEqual( stateText, 'Published' ) 
        get_web_element( test, '//h2[contains(normalize-space(), "Relationships")]').location_once_scrolled_into_view
        select_dropdown_field( test , 'categories', 'Test' )
        go_to_login_page ( test )
        go_to_login_page_subtab( test, 'blog' )
        get_web_element( test, '//*[contains( @href , "blog") and contains( normalize-space() , "Test")]' ).click()

        exist = is_text_present( test, 'I AM GP' ) # web bug it should present
        self.assertTrue( exist )

        time.sleep(2)
        test.close()

if __name__=="__main__":
    testsuite=unittest.TestSuite()
    testsuite.addTest(test_category("test_create_category"))
    testsuite.addTest(test_category("test_show_post"))
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(testsuite)