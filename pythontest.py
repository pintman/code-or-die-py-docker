import http.client
import unittest
import json

class RestTest(unittest.TestCase):
    HTTP_OK = 200

    def setUp(self):
        self.host_port = ("localhost", 80)

    def req(self, path, headers={}, raw=False):
        """Send a request to the given path and returning the response as 
        raw string or json-dictionary."""
        conn = http.client.HTTPConnection(*self.host_port)
        conn.request("GET", path, headers=headers)
        resp = conn.getresponse()
        self.assertEqual(resp.status, RestTest.HTTP_OK)
        resp = resp.read().decode("utf8").strip()
        return resp if raw else json.loads(resp)

    def test_unauthorized(self):
        self.assertIn("ships", self.req("/", raw=True))
        self.assertEqual("null", self.req("/systems", raw=True))

    def test_authorized(self):
        key1 = {"api-key": "one"}
        key2 = {"api-key": "two"}

        systems1 = self.req("/systems", key1)
        self.assertEqual(len(systems1), 1)
        systems2 = self.req("/systems", key2)
        self.assertEqual(len(systems2), 1)
        self.assertTrue(systems1[0] != systems2[0])

        sys1 = self.req("/systems/"+str(systems1[0]), key1)
        self.assertTrue(sys1["controller"] == "one")
        sys2 = self.req("/systems/"+str(systems2[0]), key2)
        self.assertTrue(sys2["controller"] == "two")


if __name__ == "__main__":
    unittest.main()
