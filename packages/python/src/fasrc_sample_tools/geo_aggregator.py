import sys
from typing import Optional

from geopandas import GeoDataFrame, sjoin
import pandas
from shapely.geometry import Point


class SimpleGISAnnotator:
    """
    This is a simplified version of
    https://github.com/NSAPH-Data-Platform/nsaph-gis/blob/main/nsaph_gis/annotator.py#L15
    """

    def __init__(self, shape_file: str, data_file: str):
        self.crs = 'EPSG:4326'
        self.shape_file = shape_file
        self.shapes: Optional[GeoDataFrame] = None
        self.data_file = data_file
        self.data: Optional[pandas.DataFrame]  = None
        return

    def join(self, output: str):
        self.shapes = GeoDataFrame.from_file(self.shape_file).to_crs(self.crs)
        self.data = pandas.read_json(self.data_file)
        geometry = [
            Point(xy) for xy in
            zip(self.data["Longitude"], self.data["Latitude"])
        ]
        points = GeoDataFrame(self.data, geometry=geometry, crs=self.crs)
        pts = sjoin(points, self.shapes, how='left')
        columns = ["ZCTA5CE20", "Parameter", "Value"]
        df = GeoDataFrame(pts[columns], geometry=geometry, crs=self.crs)
        agg = df.groupby(["ZCTA5CE20", "Parameter"]).agg("mean")
        agg.to_csv(output)
        return


if __name__ == "__main__":
    annotator = SimpleGISAnnotator(sys.argv[1], sys.argv[2])
    annotator.join(sys.argv[3])

        
        

    
