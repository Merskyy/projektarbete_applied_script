from network_config_manager import NetworkConfigManager
import pytest

class Test_nw_config:
    @pytest.fixture(autouse=True)
    def setup_teardown(self):
        self.netinst = NetworkConfigManager()
        self.netinst.connect()
        self.netinst.update_hostname("1")
        self.netinst.update_interface_state("down")
        self.netinst.update_response_prefix("Standard Response")
        yield
        self.netinst.disconnect()


    def test_hostname_value(self):
        assert  self.netinst.show_hostname() == "hostname: 1"
        
    def test_interface_state(self):
        assert self.netinst.show_interface_state() == "interface_state: down"

    def test_response_prefix(self):
        assert self.netinst.show_response_prefix() == "response_prefix: Standard Response"
    
    def test_new_hostname(self):
        self.netinst.update_hostname("2")
        assert self.netinst.show_hostname() == "hostname: 2"

    def test_new_interface_state(self):
        self.netinst.update_interface_state("up")
        assert self.netinst.show_interface_state() == "interface_state: up"
    
    def test_new_response_prefix(self):
        self.netinst.update_response_prefix("yes")
        assert self.netinst.show_response_prefix() == "response_prefix: yes"
    
    def test_different_interface_state_input(self):
        #self.netinst.update_interface_state("left")
        with pytest.raises(ValueError):
            self.netinst.update_interface_state("left")
    
    #def teardown_method(self):
    #    self.netinst.disconnect()