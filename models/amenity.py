#!/usr/bin/python3
""" Amenity Module for HBNB project """
from sqlalchemy import Column, Table, String, ForeignKey
from sqlalchemy.orm import relationship
from models.base_model import BaseModel, Base


place_amenity = Table("place_amenity", Base.metadata,
                      Column("place_id", String(60),
                             ForeignKey("places.id"),
                             primary_key=True,
                             nullable=False),
                      Column("amenity_id", String(60),
                             ForeignKey("amenities.id"),
                             primary_key=True,
                             nullable=False))

class Amenity(BaseModel, Base):
    """the class for Amenity
    Attributes:
        name: input name
    """
    __tablename__ = "amenities"
    name = Column(String(128), nullable=False)
    place_amenities = relationship("Place", secondary=place_amenity)
